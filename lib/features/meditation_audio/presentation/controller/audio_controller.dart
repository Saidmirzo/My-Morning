import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:meta/meta.dart';
import 'package:morningmagic/features/meditation_audio/data/meditation_audio_data.dart';
import 'package:morningmagic/features/meditation_audio/domain/entities/audio_file.dart';
import 'package:morningmagic/features/meditation_audio/domain/repositories/audio_repository.dart';

//TODO Fix first time file exists in cache
class AudioController extends GetxController {
  AudioController({@required this.repository});

  final AudioRepository repository;

  var audioPlayer = AudioPlayer().obs;

  List<AudioFile> audios = [];

  var selectedItemIndex = 0.obs;

  var playingIndex = (-1).obs;

  bool isPlaying = false;

  @override
  void onClose() {
    super.onClose();
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
      AudioFile audioFile = await repository.getAudioFile(trackId);
      print("AudioCache :: file cached");
      audios.add(audioFile);
    } catch (e) {}
  }

  String getAudioUrl(String trackId) {
    return MeditationAudioData.audioSources[trackId];
  }

  // TODO remove

  var downloadIngAudioTracks = <String>[].obs;

  bool isItemDownloading(String trackName) =>
      downloadIngAudioTracks.contains(trackName);

  // TODO remove
// bool isAudioDownloaded(String audioId) {
//   AudioFile audioFile = audios.firstWhere((element) => element.id == audioId,
//       orElse: () => null);
//
//   if (audioFile == null) return false;
//   return audioFile.file != null;
// }

//
// void downloadAudio(String audioId) async {
//   downloadIngAudioTracks.add(audioId);
//   try {
//     AudioFile audioFile = await repository.getAudioFile(audioId);
//     audios.add(audioFile);
//
//     await Future.delayed(Duration(milliseconds: 500));
//     downloadIngAudioTracks.removeWhere((element) => element == audioId);
//     print("file successfully downloaded");
//   } catch (e) {
//     print(e);
//     downloadIngAudioTracks.removeWhere((element) => element == audioId);
//   }
// }

}
