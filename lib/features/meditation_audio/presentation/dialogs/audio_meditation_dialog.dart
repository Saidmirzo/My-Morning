import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:morningmagic/features/meditation_audio/data/meditation_audio_data.dart';
import 'package:morningmagic/features/meditation_audio/domain/entities/meditation_audio.dart';
import 'package:morningmagic/features/meditation_audio/presentation/controller/meditation_audio_controller.dart';
import 'package:morningmagic/features/meditation_audio/presentation/dialogs/audio_meditation_dialog_item.dart';

class AudioMeditationContainer extends StatefulWidget {
  final bool withBgSound;

  const AudioMeditationContainer({Key key, this.withBgSound = false})
      : super(key: key);
  @override
  _AudioMeditationContainerState createState() =>
      _AudioMeditationContainerState();
}

class _AudioMeditationContainerState extends State<AudioMeditationContainer>
    with WidgetsBindingObserver {
  MediationAudioController _audioController;
  List<MeditationAudio> _source = [];

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
              itemCount: _source.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return AudioMeditationDialogItem(
                  id: index,
                  audio: _source[index],
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
    _source.addAll(meditationAudioData.musicSource);
    _audioController.changeAudioSource(_source, isBgSource: widget.withBgSound);
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
  }
}
