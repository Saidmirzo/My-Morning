import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:just_audio/just_audio.dart';
import 'package:morningmagic/analyticService.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/services/timer_service.dart';
import 'package:screen/screen.dart';

import '../app_states.dart';
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
  AppStates appStates = Get.put(AppStates());

  String selectedAudio;
  int index = 0;

  List<String> audios;
  final _player = AudioPlayer();

  @override
  void initState() {
    timerService.init(this, context, widget.pageId, _player);
    if (widget.pageId == 0) {
      AnalyticService.screenView('affirmation_timer_page');
    } else if (widget.pageId == 1) {
      initAudios();
      AnalyticService.screenView('meditation_timer_page');
    } else if (widget.pageId == 2) {
      print('таймер фитнес');
    } else if (widget.pageId == 4) {
      AnalyticService.screenView('reading_timer_page');
    } else if (widget.pageId == 5) {
      print('таймер визуализация');
    }
    try {
      Screen.keepOn(true);
    } catch (e) {
      log('Screen.keepOn : ' + e.toString());
    }
    super.initState();
  }

  initAudios() async {
    audios = MyDB().getBox().get(MyResource.MUSIC_CASH);
    await _player.setAudioSource(
      ConcatenatingAudioSource(
          useLazyPreparation: true, // default
          shuffleOrder: DefaultShuffleOrder(), // default
          children: List.generate(audios.length,
              (index) => AudioSource.uri(Uri.file(audios[index])))),
      initialIndex: appStates.selectedMeditationIndex.value, // default
      initialPosition: Duration.zero, // default
    );
    _player.load();
  }

  @override
  Widget build(BuildContext context) {
    log('Build timerPage');
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
                                  onPressed: _prev,
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
                                  onPressed: _playOrPause,
                                  child: Icon(
                                    _player.playing
                                        ? Icons.pause
                                        : Icons.play_arrow,
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
                                  onPressed: _next,
                                  child: Icon(
                                    Icons.fast_forward,
                                    size: 60,
                                    color: AppColors.VIOLET,
                                  ),
                                ),
                              ],
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
                            _player.stop();

                            timerService.skipTask();
                          }, () {
                            _player.stop();
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

  void _next() async {
    if (_player.currentIndex >= audios.length - 1) {
      await _player.seek(new Duration(seconds: 0), index: 0);
    } else {
      await _player.seekToNext();
    }
  }

  void _prev() async {
    if (_player.currentIndex == 0) {
      await _player.seek(new Duration(seconds: 0), index: audios.length - 1);
    } else {
      await _player.seekToPrevious();
    }
  }

  void _playOrPause() {
    _player.playing ? _player.stop() : _player.play();
  }

  @override
  void dispose() {
    super.dispose();
    _player.stop();
    _player.dispose();
    timerService.dispose();
  }
}
