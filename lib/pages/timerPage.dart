import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:morningmagic/analyticService.dart';
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
    'assets/audios/bell_temple.mp3',
    'assets/audios/dawn_chorus.mp3',
    'assets/audios/eclectopedia.mp3',
    'assets/audios/hommic.mp3',
    'assets/audios/meditation_space.mp3',
    'assets/audios/sounds_of_the_forest.mp3',
    'assets/audios/unlock_your_brainpower.mp3',
  ];
  AppStates appStates = Get.put(AppStates());
  String selectedAudio;

  @override
  void initState() {
    super.initState();
    timerService.init(this, context, widget.pageId);
    selectedAudio = _audioList[appStates.selectedMeditationIndex.value];
    if (widget.pageId == 0) {
      AnalyticService.screenView('affirmation_timer_page');
    } else if (widget.pageId == 1) {
      AnalyticService.screenView('meditation_timer_page');
    } else if (widget.pageId == 2) {
      print('таймер фитнес');
    } else if (widget.pageId == 4) {
      AnalyticService.screenView('reading_timer_page');
    } else if (widget.pageId == 5) {
      print('таймер визуализация');
    }
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
                                  RaisedButton(
                                    color: Colors.transparent,
                                    elevation: 0,
                                    autofocus: false,
                                    hoverColor: AppColors.TRANSPARENT,
                                    highlightElevation: 0,
                                    padding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                    onPressed: () {
                                      if (appStates
                                              .selectedMeditationIndex.value >
                                          0) {
                                        appStates.selectedMeditationIndex
                                            .value = appStates
                                                .selectedMeditationIndex.value -
                                            1;
                                      } else {
                                        appStates
                                            .selectedMeditationIndex.value = 6;
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
                                  RaisedButton(
                                    color: Colors.transparent,
                                    elevation: 0,
                                    autofocus: false,
                                    hoverColor: AppColors.TRANSPARENT,
                                    highlightElevation: 0,
                                    padding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                    onPressed: () {
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
                                  RaisedButton(
                                    color: Colors.transparent,
                                    elevation: 0,
                                    autofocus: false,
                                    hoverColor: AppColors.TRANSPARENT,
                                    highlightElevation: 0,
                                    padding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                    onPressed: () {
                                      if (appStates
                                              .selectedMeditationIndex.value <
                                          6) {
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
