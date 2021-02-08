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

  List<MeditationAudio> audios;

  var selectedItemIndex = 0.obs;

  var playingIndex = (-1).obs;

  bool isPlaying = false;

  @override
  void onInit() async {
    super.onInit();
    audios = await repository.getCachedAudioFiles();
    print('init audio files from cache: length = ${audios.length}');
  }

  @override
  void onClose() {
    super.onClose();
    print('audio controller on close');
    audioPlayer.value.stop();
    audioPlayer.value.dispose();
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
      print("AudioCache :: file cached");
      audios.add(audioFile);
    } catch (e) {}
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
}