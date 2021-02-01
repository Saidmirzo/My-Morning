import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:morningmagic/features/audios/domain/entities/audio_file.dart';
import 'package:morningmagic/features/audios/domain/repositories/audio_repository.dart';

class AudioController extends GetxController {
  final AudioRepository repository;

  AudioController({@required this.repository});

  var audios = <AudioFile>[].obs;

  var downloadIngAudioTracks = <String>[].obs;

  bool isItemDownloading(String trackName) =>
      downloadIngAudioTracks.contains(trackName);

  RxBool isLoading = RxBool(false);

  var audioSelectedIndex = 0.obs;

  bool isAudioDownloaded(String audioId) {
    AudioFile audioFile = audios.firstWhere((element) => element.id == audioId,
        orElse: () => null);

    if (audioFile == null) return false;
    return audioFile.file != null;
  }

  void downloadAudio(String audioId) async {
    downloadIngAudioTracks.add(audioId);
    try {
      AudioFile audioFile = await repository.getAudioFile(audioId);
      audios.add(audioFile);

      await Future.delayed(Duration(milliseconds: 500));
      downloadIngAudioTracks.removeWhere((element) => element == audioId);
      print("file successfully downloaded");
    } catch (e) {
      print(e);
      downloadIngAudioTracks.removeWhere((element) => element == audioId);
    }
  }
}
