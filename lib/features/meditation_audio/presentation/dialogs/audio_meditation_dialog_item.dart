import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:morningmagic/app_states.dart';
import 'package:morningmagic/features/meditation_audio/presentation/controller/audio_controller.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/widgets/sound_waves_diagram/my/line_box.dart';

class AudioMeditationDialogItem extends StatefulWidget {
  final int id;
  final String trackId;
  final LineBox lineBox;

  const AudioMeditationDialogItem({
    Key key,
    @required this.id,
    @required this.trackId,
    @required this.lineBox,
  });

  @override
  _AudioMeditationDialogItemState createState() =>
      _AudioMeditationDialogItemState();
}

class _AudioMeditationDialogItemState extends State<AudioMeditationDialogItem> {
  AppStates appStates = Get.find<AppStates>();
  AudioController audioController = Get.find<AudioController>();
  bool pauseSwitch = false;

  AssetsAudioPlayer _audioPlayer;

  @override
  Widget build(BuildContext context) {
    _audioPlayer = audioController.audioPlayer.value;

    return Column(
      children: [
        InkWell(
          onTap: () => audioController.selectedItemIndex.value = widget.id,
          child: Obx(() => Container(
                margin: EdgeInsets.only(bottom: 8),
                padding: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                    color: audioController.selectedItemIndex.value == widget.id
                        ? AppColors.PINK
                        : AppColors.LIGHT_VIOLET,
                    borderRadius: BorderRadius.all(Radius.circular(40))),
                child: AudioWidget(
                  play: audioController.isPlaying,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: IconButton(
                            onPressed: () async {
                              if (!audioController.isPlaying) {
                                final _oldPlayingIndex =
                                    audioController.playingIndex.value;
                                audioController.playingIndex.value = widget.id;

                                if (audioController.playingIndex.value == -1 ||
                                    _oldPlayingIndex != widget.id) {
                                  playNewTrack(widget.trackId);
                                } else
                                  _audioPlayer.play();
                              } else
                                audioController.audioPlayer.value.pause();

                              setState(() {
                                audioController.isPlaying =
                                    !audioController.isPlaying;
                              });
                              if (audioController.isPlaying) {
                                widget.lineBox.playAnimation();
                              } else {
                                widget.lineBox.stopAnimation();
                              }
                            },
                            icon: Icon(
                              // TODO change icon on playin (only for current item)
                              (audioController.playingIndex.value ==
                                          widget.id &&
                                      audioController.isPlaying)
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          widget.trackId,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            color: AppColors.WHITE,
                            fontStyle: FontStyle.normal,
                            fontFamily: 'rex',
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
        ),
      ],
    );
  }

  void playNewTrack(String trackId) async {
    String _trackUrl = audioController.getAudioUrl(trackId);
    try {
      await _audioPlayer.open(
        Audio.network(_trackUrl),
      );
    } catch (e) {
      // TODO make if not available connection

    }
  }
}
