import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:morningmagic/app_states.dart';
import 'package:morningmagic/features/audios/presentation/controller/audio_controller.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/widgets/sound_waves_diagram/my/line_box.dart';

class AudioMeditationDialogItem extends StatefulWidget {
  final String name;
  final int id;
  final LineBox lineBox;

  const AudioMeditationDialogItem({
    Key key,
    @required this.name,
    @required this.id,
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => audioController.audioSelectedIndex.value = widget.id,
          child: Obx(() => Container(
                margin: EdgeInsets.only(bottom: 8),
                padding: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                    color: audioController.audioSelectedIndex.value == widget.id
                        ? AppColors.PINK
                        : AppColors.LIGHT_VIOLET,
                    borderRadius: BorderRadius.all(Radius.circular(40))),
                child: Container(
                  height: 48,
                  margin: EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (audioController.isAudioDownloaded(widget.name))
                        AudioWidget(
                          // TODO pass url
                          audio: null,
                          // audio: Audio.file(widget.audio),
                          child: Container(
                            child: InkWell(
                              onTap: () async {
                                // TODO make audio playing
                                // appStates.player.value.playOrPause();
                                // if (pauseSwitch) {
                                //   widget.lineBox.playAnimation();
                                // } else {
                                //   widget.lineBox.stopAnimation();
                                // }
                                // print(
                                //     MyDB().getBox().get(MyResource.MUSIC_CASH));
                              },
                              child: Icon(
                                appStates.selectedMeditationIndex.value !=
                                        widget.id
                                    ? Icons.play_arrow
                                    : pauseSwitch
                                        ? Icons.pause
                                        : Icons.play_arrow,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                          play: appStates.selectedMeditationIndex.value !=
                                  widget.id
                              ? false
                              : pauseSwitch,
                        ),
                      SizedBox(width: 10),
                      Text(
                        widget.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          color: AppColors.WHITE,
                          fontStyle: FontStyle.normal,
                          fontFamily: 'rex',
                          fontSize: 17,
                        ),
                      ),
                      Spacer(),
                      if (!audioController.isAudioDownloaded(widget.name) &&
                          !audioController.isItemDownloading(widget.name))
                        IconButton(
                          icon: Icon(
                            Icons.save,
                            color: Colors.white,
                          ),
                          onPressed: () =>
                              audioController.downloadAudio(widget.name),
                        ),
                      if (audioController.isItemDownloading(widget.name))
                        Container(
                            margin: EdgeInsets.all(8),
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            )),
                      SizedBox(
                        width: 4,
                      ),
                    ],
                  ),
                ),
              )),
        ),
      ],
    );
  }
}
