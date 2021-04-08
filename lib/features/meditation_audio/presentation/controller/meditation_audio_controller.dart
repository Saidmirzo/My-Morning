import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:meta/meta.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/features/meditation_audio/data/meditation_audio_data.dart';
import 'package:morningmagic/features/meditation_audio/domain/entities/meditation_audio.dart';
import 'package:morningmagic/features/meditation_audio/domain/repositories/audio_repository.dart';

import '../../domain/entities/meditation_audio.dart';

// Для работы изолятора функция должна находиться вне класса
// В этой функции готовим список треков для диалога,
// без изолятора подтормаживает при открытии
List<MeditationAudio> getAudios(Map audioSource) {
  List<MeditationAudio> _audios = [];
  audioSource.forEach((key, value) {
    _audios.add(MeditationAudio(id: key, url: value, filePath: null));
  });
  return _audios;
}

class MediationAudioController extends GetxController {
  MediationAudioController({@required this.repository});

  final AudioRepository repository;

  var audioPlayer = AudioPlayer().obs;

  get player => audioPlayer.value;

  List<MeditationAudio> audios = <MeditationAudio>[];
  var favoriteAudios = RxList<MeditationAudio>().obs;

  var selectedItemIndex = 0.obs;

  var playingIndex = (-1).obs;

  RxBool isPlaying = false.obs;
  var isAudioLoading = false.obs;
  var isAudioListLoading = false.obs;

  bool playFromFavorite = false;

  List<AudioSource> playList;
  RxString currAudioName = ''.obs;
  List<String> audioNames = [];

  Map<String, String> audioSource = MeditationAudioData.musicSource;

  bool get isPlaylistAudioCached =>
      player.currentIndex < audios.length &&
      audios[player.currentIndex].filePath != null;

  @override
  void onInit() async {
    super.onInit();
    print('audioController: onInit');
  }

  @override
  void onClose() {
    super.onClose();
    print('Meditation audio controller closed, player stopped and disposed');
    player.stop();
    player.dispose();
  }

  Future<void> reinitAudioSource({bool fromDialog = false}) async {
    isAudioListLoading.value = true;
    audios.clear();
    player.playerStateStream.listen((state) {
      if (!state.playing &&
          (state.processingState.index == ProcessingState.loading.index ||
              state.processingState.index == ProcessingState.buffering.index)) {
        isAudioLoading.value = true;
      } else
        isAudioLoading.value = false;
    });
    if (playFromFavorite) {
      print('playFromFavorite');
      audios.addAll(favoriteAudios.value);
    } else {
      print('play From audioSource');
      if (fromDialog)
        audios = await compute(getAudios, audioSource);
      else
        audios.addAll(await repository.getCachedAudioFiles(audioSource));
      print('new audios lng: ${audios.length}');
    }
    print('audios  lng: ${audios.length}');
    (await repository.getFavoriteAudioFiles()).forEach((element) {
      if (!favoriteAudios.value.contains(element))
        favoriteAudios.value.add(element);
    });
    isAudioListLoading.value = false;
  }

  void setAudioFavorite(MeditationAudio audio) async {
    favoriteAudios.value.contains(audio)
        ? favoriteAudios.value.remove(audio)
        : favoriteAudios.value.add(audio);
    await MyDB()
        .getBox()
        .put(MyResource.MEDITATION_AUDIO_FAVORITE, favoriteAudios.value);
  }

  Future<File> getCachedAudioFile(MeditationAudio track) async {
    final audioFile =
        audios.firstWhere((element) => element == track, orElse: () => null);
    if (audioFile?.filePath != null) {
      return File(audioFile.filePath);
    } else {
      var fl = await cacheAudioFile(track);
      return fl != null ? File(fl.filePath) : null;
    }
  }

  Future<MeditationAudio> cacheAudioFile(MeditationAudio track) async {
    try {
      MeditationAudio audioFile = await repository.getAudioFile(track);
      audios.add(audioFile);
      return audioFile;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<List<AudioSource>> generateMeditationPlayList() async {
    List<AudioSource> _result = [];
    audioNames.clear();
    if (playFromFavorite) {
      print('generateMeditationPlayList: playFromFavorite');
      favoriteAudios.value.forEach((value) {
        audioNames.add(value.id);
        final _cachedAudio = audios.firstWhere(
          (cachedAudio) => cachedAudio.id == value.id,
          orElse: () => null,
        );
        if (_cachedAudio != null && _cachedAudio.filePath != null) {
          print('_cachedAudio.filePath: ${_cachedAudio.filePath}');
          _result.add(AudioSource.uri(Uri.file(_cachedAudio.filePath)));
        } else {
          print('url: ${value.url}');
          _result.add(ProgressiveAudioSource(Uri.parse(value.url)));
          cacheAudioFile(value);
        }
      });
      print('audioNames: ${audioNames.toList()}');
      currAudioName.value = audioNames[selectedItemIndex.value];
    } else {
      audioNames = audioSource == null || audioSource.isEmpty
          ? MeditationAudioData.musicSource.keys.toList()
          : audioSource.keys.toList();
      currAudioName.value = audioNames[selectedItemIndex.value];
      audioSource.forEach((trackId, url) {
        final _cachedAudio = audios.firstWhere(
          (cachedAudio) => cachedAudio.id == trackId,
          orElse: () => null,
        );
        if (_cachedAudio != null && _cachedAudio.filePath != null) {
          _result.add(AudioSource.uri(Uri.file(_cachedAudio.filePath)));
        } else {
          _result.add(ProgressiveAudioSource(Uri.parse(url)));
          cacheAudioFile(
              MeditationAudio(id: trackId, url: url, filePath: null));
        }
      });
    }

    return _result;
  }

  void initializeMeditationAudio({bool autoplay = true}) async {
    await reinitAudioSource();
    playList = await generateMeditationPlayList();
    print('playlist length: ${playList.length}');
    await player.setAudioSource(
      ConcatenatingAudioSource(
          children: List.generate(playList.length, (index) => playList[index])),
      initialIndex: selectedItemIndex.value,
      initialPosition: Duration.zero,
    );
    await player.setLoopMode(LoopMode.one);
    player.playingStream.listen((event) {
      if (isPlaying.value != event) isPlaying.value = event;
    });
    if (autoplay) player.play();
  }

  void next() {
    final _playListLength = playList.length;
    if (_playListLength == 0) return;
    int _nextIndex = 0;
    if (player.currentIndex + 1 >= _playListLength)
      _nextIndex = 0;
    else
      _nextIndex = player.currentIndex + 1;
    player.seek(Duration(seconds: 0), index: _nextIndex);
    currAudioName.value = audioNames[_nextIndex];
    if (!player.playing) player.play();
  }

  void prev() {
    final _playListLength = playList.length;
    if (_playListLength == 0) return;
    int _nextIndex = 0;
    if (player.currentIndex == 0)
      _nextIndex = _playListLength - 1;
    else
      _nextIndex = player.currentIndex - 1;
    player.seek(Duration(seconds: 0), index: _nextIndex);
    currAudioName.value = audioNames[_nextIndex];
    if (!player.playing) player.play();
  }

  void playOrPause() {
    player.playing ? player.pause() : player.play();
  }
}
