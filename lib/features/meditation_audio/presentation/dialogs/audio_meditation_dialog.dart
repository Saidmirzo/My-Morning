import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:morningmagic/features/meditation_audio/data/meditation_audio_data.dart';
import 'package:morningmagic/features/meditation_audio/presentation/controller/meditation_audio_controller.dart';
import 'package:morningmagic/features/meditation_audio/presentation/dialogs/audio_meditation_dialog_item.dart';
import 'package:morningmagic/resources/colors.dart';

class AudioMeditationDialog extends StatefulWidget {
  @override
  _AudioMeditationDialogState createState() => _AudioMeditationDialogState();
}

class _AudioMeditationDialogState extends State<AudioMeditationDialog> {

  @override
  Widget build(BuildContext context) {
    final _audioTrackNames = MeditationAudioData.audioSources.keys.toList();

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(
                    8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildDialogActionButton(
                      context: context,
                      title: 'back_button'.tr,
                      onTap: () {
                        Navigator.pop(context);
                        _stopPlayer();
                      },
                    ),
                    _buildDialogActionButton(
                      context: context,
                      title: 'choose'.tr,
                      onTap: () {
                        Navigator.pop(context);
                        _stopPlayer();
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: _buildSelectAudioList(_audioTrackNames),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListView _buildSelectAudioList(List<String> _audioTrackNames) {
    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(vertical: 16),

      itemCount: _audioTrackNames.length,
      //appStates.meditationPlaylist.value.audios.length,
      separatorBuilder: (context, index) => SizedBox(height: 10),
      itemBuilder: (context, index) {
        print(index);
        return AudioMeditationDialogItem(
          id: index,
          trackId: _audioTrackNames[index],
        );
      },
    );
  }

  InkWell _buildDialogActionButton(
      {@required BuildContext context,
      @required String title,
      @required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 23,
              fontFamily: 'rex',
              fontStyle: FontStyle.normal,
              color: AppColors.VIOLET),
        ),
      ),
    );
  }

  void _stopPlayer() {
    final _audioController = Get.find<MediationAudioController>();
    _audioController.audioPlayer.value.pause();
    _audioController.isPlaying = false;
  }
}
