import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:morningmagic/features/meditation_audio/data/meditation_audio_data.dart';
import 'package:morningmagic/features/meditation_audio/presentation/controller/meditation_audio_controller.dart';
import 'package:morningmagic/features/meditation_audio/presentation/dialogs/audio_meditation_dialog_item.dart';

class YogaMeditationContainer extends StatefulWidget {
  @override
  _YogaMeditationContainerState createState() =>
      _YogaMeditationContainerState();
}

class _YogaMeditationContainerState extends State<YogaMeditationContainer>
    with WidgetsBindingObserver {
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
      return _audioController.isAudioListLoading?.value ?? false
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
    _audioController.selectedItemIndex.value = 0;
  }

  @override
  void initState() {
    _audioController = Get.find();
    _audioController.audioSource = MeditationAudioData.yogaSource;
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _stopPlayer();
      _audioController.playFromFavorite = false;
      _audioController.reinitAudioSource(fromDialog: true);
    });
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }
}
