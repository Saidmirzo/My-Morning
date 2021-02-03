import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:morningmagic/features/meditation_audio/data/meditation_audio_data.dart';
import 'package:morningmagic/features/meditation_audio/domain/entities/audio_file.dart';
import 'package:morningmagic/features/meditation_audio/domain/repositories/audio_repository.dart';

class AudioController extends GetxController {

  AudioController({@required this.repository});

  final AudioRepository repository;

  var audioPlayer = AssetsAudioPlayer().obs;

  var audios = <AudioFile>[].obs;

  var downloadIngAudioTracks = <String>[].obs;

  bool isItemDownloading(String trackName) =>
      downloadIngAudioTracks.contains(trackName);

  var selectedItemIndex = 0.obs;

  var playingIndex = (-1).obs;

  bool isPlaying = false;


  @override
  void onClose() {
    super.onClose();
    audioPlayer.value.stop();
    audioPlayer.value.dispose();
    print('audiocontroller disposed');
  }

  bool isAudioDownloaded(String audioId) {
    AudioFile audioFile = audios.firstWhere((element) => element.id == audioId,
        orElse: () => null);

    if (audioFile == null) return false;
    return audioFile.file != null;
  }

  // TODO remove
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

  String getAudioUrl(String trackId) {
    return MeditationAudioData.audioSources[trackId];
  }
}
