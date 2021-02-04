import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:just_audio/just_audio.dart';
import 'package:morningmagic/analyticService.dart';
import 'package:morningmagic/dialog/affirmation_category_dialog.dart';
import 'package:morningmagic/features/meditation_audio/presentation/controller/meditation_audio_controller.dart';
import 'package:morningmagic/services/timer_service.dart';
import 'package:morningmagic/widgets/animatedButton.dart';
import 'package:screen/screen.dart';

import '../resources/colors.dart';
import '../utils/string_util.dart';
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
  final _audioController = Get.find<MediationAudioController>();

  TimerService timerService = TimerService();
  AudioPlayer _audioPlayer;
  String titleText;
  List<AudioSource> _playList;
  bool isInitialized = false;
  int index = 0;

  @override
  void initState() {
    super.initState();
    _audioPlayer = _audioController.audioPlayer.value;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await timerService.init(this, context, widget.pageId, _audioPlayer);
      if (widget.pageId == 0 && timerService.affirmationText != null)
        titleText = timerService.affirmationText;
      else if (widget.pageId == 5 && timerService.visualizationText != null)
        titleText = timerService.visualizationText;
    });

    if (widget.pageId == 0) {
      AnalyticService.screenView('affirmation_timer_page');
    } else if (widget.pageId == 1) {
      // meditation page
      initializeMeditationAudio();
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
  }

  initializeMeditationAudio() async {
    _playList = _audioController.generateMeditationPlayList();

    await _audioPlayer.setAudioSource(
      ConcatenatingAudioSource(
          children:
              List.generate(_playList.length, (index) => _playList[index])),
      initialIndex: _audioController.selectedItemIndex.value,
      initialPosition: Duration.zero,
    );

    _audioPlayer.load();
    _audioPlayer.play();
  }

  @override
  Widget build(BuildContext context) {
    if (!isInitialized) {
      isInitialized = true;
      timerService.buttonText = 'start'.tr();
    }

    return SafeArea(
      child: Scaffold(
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
                                      _audioPlayer.playing
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
                          SizedBox(
                            height: 24,
                          ),
                          if (titleText != null) _buildTitleWidget(),
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
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: AnimatedButton(
                                      () => timerService.startTimer(),
                                      'rex',
                                      timerService.buttonText,
                                      15,
                                      null,
                                      null),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 10),
                                  child: AnimatedButton(() {
                                    _audioPlayer.stop();
                                    timerService.skipTask();
                                  }, 'rex', 'skip'.tr(), 15, null, null),
                                ),
                                if (widget.pageId == 0)
                                  Container(
                                    padding: EdgeInsets.only(top: 10),
                                    child: AnimatedButton(() async {
                                      final _affirmation =
                                          await _showAffirmationCategoryDialog(
                                              context);
                                      if (_affirmation != null)
                                        setState(() {
                                          titleText = _affirmation;
                                        });
                                    }, 'rex', 'Аффирмации'.tr(), 15, null,
                                        null),
                                  ),
                                Container(
                                  padding: EdgeInsets.only(top: 10),
                                  child: AnimatedButton(() {
                                    _audioPlayer.stop();
                                    timerService.goToHome();
                                  }, 'rex', 'menu'.tr(), 15, null, null),
                                )
                              ],
                            ),
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
      ),
    );
  }

  Future<String> _showAffirmationCategoryDialog(BuildContext context) async {
    return await showDialog(
        context: context, child: AffirmationCategoryDialog());
  }

  Widget _buildTitleWidget() {
    return Container(
      padding: EdgeInsets.only(left: 5, right: 5, bottom: 30),
      child: CustomText(
        text: titleText,
        size: 22,
      ),
    );
  }

  void _next() async {
    if (_audioPlayer.currentIndex >= _playList.length - 1) {
      await _audioPlayer.seek(new Duration(seconds: 0), index: 0);
    } else {
      await _audioPlayer.seekToNext();
    }
  }

  void _prev() async {
    if (_audioPlayer.currentIndex == 0) {
      await _audioPlayer.seek(new Duration(seconds: 0),
          index: _playList.length - 1);
    } else {
      await _audioPlayer.seekToPrevious();
    }
  }

  void _playOrPause() {
    _audioPlayer.playing ? _audioPlayer.stop() : _audioPlayer.play();
  }

  @override
  void dispose() {
    super.dispose();

    timerService.dispose();
  }
}
