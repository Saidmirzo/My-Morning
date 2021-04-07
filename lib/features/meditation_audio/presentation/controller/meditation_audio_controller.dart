import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:meta/meta.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/features/meditation_audio/data/meditation_audio_data.dart';
import 'package:morningmagic/features/meditation_audio/domain/entities/meditation_audio.dart';
import 'package:morningmagic/features/meditation_audio/domain/repositories/audio_repository.dart';
import 'package:morningmagic/pages/meditation/components/menu.dart';
import 'package:morningmagic/pages/meditation/controllers/menu_controller.dart';

class MediationAudioController extends GetxController {
  MediationAudioController({@required this.repository});

  final AudioRepository repository;

  var audioPlayer = AudioPlayer().obs;

  get player => audioPlayer.value;

  final List<MeditationAudio> audios = <MeditationAudio>[];
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

  Future<void> reinitAudioSource() async {
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
      audios.addAll(favoriteAudios.value);
    } else {
      audios.addAll(await repository.getCachedAudioFiles(audioSource));
    }
    print('audios  lng: ${audios.length}');
    (await repository.getFavoriteAudioFiles()).forEach((element) {
      if (!favoriteAudios.value.contains(element))
        favoriteAudios.value.add(element);
    });
  }

  void setAudioFavorite(MeditationAudio audio) async {
    favoriteAudios.value.contains(audio)
        ? favoriteAudios.value.remove(audio)
        : favoriteAudios.value.add(audio);
    await MyDB()
        .getBox()
        .put(MyResource.MEDITATION_AUDIO_FAVORITE, favoriteAudios.value);
  }

  Future<File> getCachedAudioFile(String trackId) async {
    final audioFile = audios.firstWhere((element) => element.id == trackId,
        orElse: () => null);
    if (audioFile != null) {
      return File(audioFile.filePath);
    } else {
      _cacheAudioFile(trackId);
      return Future.value(null);
    }
  }

  Future _cacheAudioFile(String trackId) async {
    try {
      MeditationAudio audioFile =
          await repository.getAudioFile(trackId, audioSource);
      print("Meditation audio cached: $trackId");
      audios.add(audioFile);
    } catch (e) {
      print(e);
    }
  }

  String getAudioUrl(String trackId) {
    AudioMenuController cMenu = Get.find();
    switch (cMenu.currentPage.value) {
      case MenuItems.music:
        return MeditationAudioData.musicSource[trackId];
        break;
      case MenuItems.sounds:
        return MeditationAudioData.soundSource[trackId];
        break;
      default:
        return MeditationAudioData.musicSource[trackId];
    }
  }

  Future<List<AudioSource>> generateMeditationPlayList() async {
    List<AudioSource> _result = [];
    if (playFromFavorite) {
      currAudioName.value =
          favoriteAudios.value.toList().elementAt(selectedItemIndex.value).id;
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
          _cacheAudioFile(value.id);
        }
      });
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
          _cacheAudioFile(trackId);
        }
      });
    }

    return _result;
  }

  void initializeMeditationAudio({bool autoplay = true}) async {
    isAudioListLoading.value = true;
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
    isAudioListLoading.value = false;
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
