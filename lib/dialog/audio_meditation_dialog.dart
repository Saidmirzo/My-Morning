import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_visualizers/Visualizers/LineVisualizer.dart';
import 'package:flutter_visualizers/visualizer.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:morningmagic/app_states.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/widgets/sound_waves_diagram/my/line_box.dart';

class AudioMeditationDialog extends StatefulWidget {
  @override
  _AudioMeditationDialogState createState() => _AudioMeditationDialogState();
}

class _AudioMeditationDialogState extends State<AudioMeditationDialog> {
  LineBox lineBox = LineBox(lines: 36);
  AppStates appStates = Get.put(AppStates());
  List<String> _audioList = [
    'assets/audios/bell_temple.mp3',
    'assets/audios/dawn_chorus.mp3',
    'assets/audios/eclectopedia.mp3',
    'assets/audios/hommic.mp3',
    'assets/audios/meditation_space.mp3',
    'assets/audios/sounds_of_the_forest.mp3',
    'assets/audios/unlock_your_brainpower.mp3',
  ];
  List<String> listNames = [
    'Bell temple',
    'Dawn chorus',
    'Eclectopedia',
    'Hommic',
    'Meditation space',
    'Sounds of the forest',
    'Unlock your brainpower'
  ];

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, modalSetState) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Container(
          height: MediaQuery.of(context).size.height < 668
                    ? MediaQuery.of(context).size.height / 1.35
                    : MediaQuery.of(context).size.height / 1.5,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                            'back_button'.tr(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 23,
                                fontFamily: 'rex',
                                fontStyle: FontStyle.normal,
                                color: AppColors.VIOLET),
                          ),
                      ),
                      InkWell(
                        onTap: () {
                          modalSetState(() {
                            Navigator.pop(context);
                          });
                        },
                        child: Text(
                          'choose'.tr(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 23,
                              fontFamily: 'rex',
                              fontStyle: FontStyle.normal,
                              color: AppColors.VIOLET),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                ListView.separated(
                  shrinkWrap: true,
                  itemCount: _audioList.length,
                  separatorBuilder: (context, index) => SizedBox(height: 10),
                  itemBuilder: (context, index) => Obx(
                    () => MainAudioMeditationDialogItem(
                        audio: _audioList[index],
                        name: listNames[index],
                        player: appStates.audioList[index],
                        lineBox: lineBox,
                        id: index,
                        modalSetState: modalSetState),
                  ),
                ),
                SizedBox(height: 20),
                lineBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MainAudioMeditationDialogItem extends StatefulWidget {
  final String audio;
  final String name;
  final AssetsAudioPlayer player;
  final int id;
  final LineBox lineBox;
  final void Function(void Function()) modalSetState;

  const MainAudioMeditationDialogItem(
      {Key key,
      @required this.audio,
      @required this.name,
      this.player,
      this.id,
      this.lineBox,
      this.modalSetState});

  @override
  _MainAudioMeditationDialogItemState createState() =>
      _MainAudioMeditationDialogItemState();
}

class _MainAudioMeditationDialogItemState
    extends State<MainAudioMeditationDialogItem> {
  AppStates appStates = Get.put(AppStates());
  bool pauseSwitch = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            widget.modalSetState(() {
              appStates.selectedMeditationIndex.value = widget.id;
            });
          },
          child: Obx(() => Container(
                width: MediaQuery.of(context).size.width / 1.0,
                height: 30,
                margin: EdgeInsets.only(bottom: 10),
                padding: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                    color: appStates.selectedMeditationIndex.value == widget.id
                        ? AppColors.PINK
                        : AppColors.LIGHT_VIOLET,
                    borderRadius: BorderRadius.all(Radius.circular(40))),
                child: Container(
                  child: Row(
                    children: [
                      AudioWidget.assets(
                        path: widget.audio,
                        child: Container(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () async {
                              widget.modalSetState(() {
                                pauseSwitch = !pauseSwitch;
                                appStates.selectedMeditationIndex.value =
                                    widget.id;
                              });
                              widget.player.playOrPause();
                              if (pauseSwitch) {
                                widget.lineBox.playAnimation();
                              } else {
                                widget.lineBox.stopAnimation();
                              }
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
                        play:
                            appStates.selectedMeditationIndex.value != widget.id
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
                    ],
                  ),
                ),
              )),
        ),
      ],
    );
  }
}
