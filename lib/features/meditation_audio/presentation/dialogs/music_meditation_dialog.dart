import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:morningmagic/features/meditation_audio/data/meditation_audio_data.dart';
import 'package:morningmagic/features/meditation_audio/presentation/controller/meditation_audio_controller.dart';
import 'package:morningmagic/features/meditation_audio/presentation/dialogs/audio_meditation_dialog_item.dart';

class MusicMeditationContainer extends StatefulWidget {
  final bool withBgSound;

  const MusicMeditationContainer({Key key, this.withBgSound = false})
      : super(key: key);

  @override
  _MusicMeditationContainerState createState() =>
      _MusicMeditationContainerState();
}

class _MusicMeditationContainerState extends State<MusicMeditationContainer>
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
      print('page: ${_audioController.currentPage.value}');
      return _audioController.isAudioListLoading.value
          ? Center(child: CupertinoActivityIndicator())
          : ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(vertical: 16),
              itemCount: _audioController.audioSource.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return AudioMeditationDialogItem(
                  id: index,
                  audio: _audioController.audioSource[index],
                );
              },
            );
    });
  }

  void _stopPlayer() {
    _audioController.bfPlayer.value.stop();
    _audioController.playingIndex.value = -1;
    if (!widget.withBgSound) _audioController.changeItem(0);
    _audioController.bufIdSelected(0);
  }

  @override
  void initState() {
    _audioController = Get.find();
    print('Init music container');
    _audioController.changeAudioSource(meditationAudioData.musicSource);
    print('new audioSource length: ${meditationAudioData.musicSource.length}');
    if (widget.withBgSound)
      _audioController.changeAudioSource(meditationAudioData.musicSource,
          isBgSource: true);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _stopPlayer();
      _audioController.playFromFavorite = false;
      _audioController.reinitAudioSource(fromDialog: true);
    });
  }
}
