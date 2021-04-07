import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:morningmagic/features/meditation_audio/data/meditation_audio_data.dart';
import 'package:morningmagic/features/meditation_audio/presentation/controller/meditation_audio_controller.dart';
import 'package:morningmagic/features/meditation_audio/presentation/dialogs/audio_meditation_dialog_item.dart';
import 'package:morningmagic/pages/meditation/components/menu.dart';

class MusicMeditationContainer extends StatefulWidget {
  @override
  _MusicMeditationContainerState createState() =>
      _MusicMeditationContainerState();
}

class _MusicMeditationContainerState extends State<MusicMeditationContainer> {
  MediationAudioController _audioController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: _buildSelectAudioList(),
    );
  }

  Widget _buildSelectAudioList() {
    return Obx(() {
      return _audioController.isAudioListLoading.value
          ? Center(child: CupertinoActivityIndicator())
          : ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(vertical: 16),
              itemCount: _audioController.audios.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return AudioMeditationDialogItem(
                  id: index,
                  audio: _audioController.audios[index],
                );
              },
            );
    });
  }

  void _stopPlayer() {
    _audioController.player.stop();
    _audioController.isPlaying.value = false;
    _audioController.playingIndex.value = -1;
  }

  @override
  void initState() {
    _audioController = Get.find();
    _audioController.audioSource = MeditationAudioData.musicSource;
    _audioController.playFromFavorite = false;
    _audioController.initializeMeditationAudio(autoplay: false);
    _stopPlayer();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
