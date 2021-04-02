import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:morningmagic/features/meditation_audio/data/meditation_audio_data.dart';
import 'package:morningmagic/features/meditation_audio/presentation/controller/meditation_audio_controller.dart';
import 'package:morningmagic/features/meditation_audio/presentation/dialogs/audio_meditation_dialog_item.dart';

class AudioMeditationContainer extends StatefulWidget {
  @override
  _AudioMeditationContainerState createState() =>
      _AudioMeditationContainerState();
}

class _AudioMeditationContainerState extends State<AudioMeditationContainer> {
  @override
  Widget build(BuildContext context) {
    final _audioTrackNames = MeditationAudioData.audioSources.keys.toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: _buildSelectAudioList(_audioTrackNames),
    );
  }

  ListView _buildSelectAudioList(List<String> _audioTrackNames) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(vertical: 16),
      itemCount: _audioTrackNames.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return AudioMeditationDialogItem(
          id: index,
          trackId: _audioTrackNames[index],
        );
      },
    );
  }

  void _stopPlayer() {
    final _audioController = Get.find<MediationAudioController>();
    _audioController.player.pause();
    _audioController.isPlaying.value = false;
  }
}
