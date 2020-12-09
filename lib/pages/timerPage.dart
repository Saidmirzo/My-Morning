import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:morningmagic/app_states.dart';
import 'package:morningmagic/services/timer_service.dart';

import '../resources/colors.dart';
import '../utils/string_util.dart';
import '../widgets/customStartSkipColumn.dart';
import '../widgets/customText.dart';
import '../widgets/custom_progress_bar/circleProgressBar.dart';

bool isPlayed = false;

class TimerPage extends StatefulWidget {
  final int pageId;

  const TimerPage({Key key, @required this.pageId}) : super(key: key);

  @override
  State createState() => TimerPageState();
}

class TimerPageState extends State<TimerPage> {
  bool isInitialized = false;
  TimerService timerService = TimerService();
  List<String> _audioList = [
    'assets/audios/morning_glory.mp3',
    'assets/audios/morning_space.mp3',
    'assets/audios/morning_sunshine.mp3',
    'assets/audios/relaxing_journey.mp3',
  ];
  AppStates appStates = Get.put(AppStates());
  String selectedAudio;

  @override
  void initState() {
    super.initState();
    timerService.init(this, context, widget.pageId);
    selectedAudio = _audioList[appStates.selectedMeditationIndex.value];
  }

  @override
  Widget build(BuildContext context) {
    if (!isInitialized) {
      isInitialized = true;
      timerService.buttonText = 'start'.tr();
    }
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: Container(
                width: MediaQuery.of(context)
                    .size
                    .width, // match parent(all screen)
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.TOP_GRADIENT,
                    AppColors.MIDDLE_GRADIENT,
                    AppColors.BOTTOM_GRADIENT
                  ],
                )),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    widget.pageId == 1
                        ? Container(
                            margin: EdgeInsets.only(top: 50),
                            child: AudioWidget.assets(
                              loop: true,
                              path: selectedAudio,
                              play: isPlayed,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (appStates
                                              .selectedMeditationIndex.value >
                                          0) {
                                        appStates.selectedMeditationIndex
                                            .value = appStates
                                                .selectedMeditationIndex.value -
                                            1;
                                      } else {
                                        appStates
                                            .selectedMeditationIndex.value = 3;
                                      }
                                      setState(() {
                                        selectedAudio = _audioList[appStates
                                            .selectedMeditationIndex.value];
                                      });
                                    },
                                    child: Icon(
                                      Icons.fast_rewind,
                                      size: 60,
                                      color: AppColors.VIOLET,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        isPlayed = !isPlayed;
                                      });
                                    },
                                    child: Icon(
                                      isPlayed ? Icons.pause : Icons.play_arrow,
                                      size: 60,
                                      color: AppColors.VIOLET,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (appStates
                                              .selectedMeditationIndex.value <
                                          3) {
                                        appStates.selectedMeditationIndex
                                            .value = appStates
                                                .selectedMeditationIndex.value +
                                            1;
                                      } else {
                                        appStates
                                            .selectedMeditationIndex.value = 0;
                                      }
                                      selectedAudio = _audioList[appStates
                                          .selectedMeditationIndex.value];
                                    },
                                    child: Icon(
                                      Icons.fast_forward,
                                      size: 60,
                                      color: AppColors.VIOLET,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container(),
                    Column(
                      children: [
                        getAffirmationWidget(),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: CircleProgressBar(
                            text: StringUtil()
                                .createTimeString(timerService.time),
                            foregroundColor: AppColors.WHITE,
                            value: timerService.createValue(),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 40),
                          child: StartSkipColumn(
                              () => timerService.startTimer(), () {
                            setState(() {
                              isPlayed = false;
                            });

                            timerService.skipTask();
                          }, () {
                            setState(() {
                              isPlayed = false;
                            });
                            timerService.goToHome();
                          }, timerService.buttonText),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 10),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget getAffirmationWidget() {
    if (widget.pageId == 0 && timerService.affirmationText != null) {
      return Container(
        padding: EdgeInsets.only(left: 5, right: 5, bottom: 30),
        child: CustomText(
          text: timerService.affirmationText,
          size: 22,
        ),
      );
    } else if (widget.pageId == 5 && timerService.visualizationText != null) {
      return Container(
        padding: EdgeInsets.only(left: 5, right: 5, bottom: 30),
        child: CustomText(
          text: timerService.visualizationText,
          size: 22,
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  void dispose() {
    super.dispose();
    timerService.dispose();
  }
}
