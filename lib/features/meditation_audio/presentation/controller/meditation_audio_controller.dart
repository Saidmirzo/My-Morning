import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:meta/meta.dart';
import 'package:morningmagic/features/meditation_audio/data/meditation_audio_data.dart';
import 'package:morningmagic/features/meditation_audio/domain/entities/meditation_audio.dart';
import 'package:morningmagic/features/meditation_audio/domain/repositories/audio_repository.dart';

class MediationAudioController extends GetxController {
  MediationAudioController({@required this.repository});

  final AudioRepository repository;

  var audioPlayer = AudioPlayer().obs;

  get player => audioPlayer.value;

  final List<MeditationAudio> audios = <MeditationAudio>[];

  var selectedItemIndex = 0.obs;

  var playingIndex = (-1).obs;

  RxBool isPlaying = false.obs;
  var isAudioLoading = false.obs;

  List<AudioSource> playList;

  bool get isPlaylistAudioCached =>
      player.currentIndex < audios.length &&
      audios[player.currentIndex].file != null;

  @override
  void onInit() async {
    super.onInit();
    audios.addAll(await repository.getCachedAudioFiles());
    player.playerStateStream.listen((state) {
      if (!state.playing &&
          (state.processingState.index == ProcessingState.loading.index ||
              state.processingState.index == ProcessingState.buffering.index)) {
        isAudioLoading.value = true;
      } else
        isAudioLoading.value = false;
    });
  }

  @override
  void onClose() {
    super.onClose();
    print('Meditation audio controller closed, player stopped and disposed');
    player.stop();
    player.dispose();
  }

  Future<File> getCachedAudioFile(String trackId) async {
    final audioFile = audios.firstWhere((element) => element.id == trackId,
        orElse: () => null);
    if (audioFile != null) {
      return audioFile.file;
    } else {
      _cacheAudioFile(trackId);
      return Future.value(null);
    }
  }

  Future _cacheAudioFile(String trackId) async {
    try {
      MeditationAudio audioFile = await repository.getAudioFile(trackId);
      print("Meditation audio cached: $trackId");
      audios.add(audioFile);
    } catch (e) {
      print(e);
    }
  }

  String getAudioUrl(String trackId) {
    return MeditationAudioData.audioSources[trackId];
  }

  List<AudioSource> generateMeditationPlayList() {
    List<AudioSource> _result = [];
    MeditationAudioData.audioSources.forEach((trackId, url) {
      final _cachedAudio = audios.firstWhere(
        (cachedAudio) => cachedAudio.id == trackId,
        orElse: () => null,
      );
      if (_cachedAudio != null && _cachedAudio.file != null) {
        _result.add(AudioSource.uri(Uri.file(_cachedAudio.file.path)));
      } else {
        _result.add(ProgressiveAudioSource(Uri.parse(url)));
        _cacheAudioFile(trackId);
      }
    });
    return _result;
  }

  void initializeMeditationAudio() async {
    playList = generateMeditationPlayList();
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
    player.play();
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
    if (!player.playing) player.play();
  }

  void playOrPause() {
    player.playing ? player.pause() : player.play();
  }
}
