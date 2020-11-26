import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/model/exercise_time/exercise_time.dart';
import 'package:morningmagic/db/model/progress/day/day.dart';
import 'package:morningmagic/db/model/progress/visualization_progress/visualization_progress.dart';
import 'package:morningmagic/db/model/visualization/visualization.dart';
import 'package:morningmagic/db/progress.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/pages/success/screenTimerSuccess.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/utils/reordering_util.dart';
import 'package:morningmagic/utils/string_util.dart';
import 'package:morningmagic/widgets/customStartSkipColumn.dart';
import 'package:morningmagic/widgets/custom_progress_bar/circleProgressBar.dart';
import 'package:easy_localization/easy_localization.dart';

class TimerVisualizationScreen extends StatefulWidget {
  @override
  State createState() {
    return TimerVisualizationScreenState();
  }
}

class TimerVisualizationScreenState extends State<TimerVisualizationScreen> {
  Timer _timer;
  int _time;
  int _startTime;
  int _startValue;
  bool timerSwitch = false;
  String visualizationText;
  String buttonText;

  bool isInitialized = false;

  Future<Box> getTimeAndText() async {
    return await MyDB().getBox();
  }

  @override
  void initState() {
    getTimeAndText().then((Box box) {
      ExerciseTime time = box.get(MyResource.VISUALIZATION_TIME_KEY, defaultValue: ExerciseTime(0));
      Visualization visualization = box.get(MyResource.VISUALIZATION_KEY, defaultValue: Visualization(""));
      visualizationText = visualization.visualization;
      _time = time.time * 60;
      _startTime = time.time;
      _startValue = time.time * 60;
      startTimer();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!isInitialized) {
      isInitialized = true;
      buttonText = 'start'.tr();
    }
    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Scaffold(body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(minHeight: viewportConstraints.maxHeight),
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 6),
                        child: Visibility(
                          visible: timerSwitch,
                          maintainSize: true,
                          maintainState: true,
                          maintainAnimation: true,
                          child: Text(
                            'timer_started'.tr(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontStyle: FontStyle.normal,
                                fontFamily: 'rex',
                                fontSize: 25,
                                color: AppColors.WHITE),
                          ),
                        )),
                    Container(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 19),
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: CircleProgressBar(
                        text: StringUtil().createTimeString(_time),
                        foregroundColor: AppColors.WHITE,
                        value: createValue(),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 30),
                      child: StartSkipColumn(() {
                        startTimer();
                      }, () {
                        if (_timer != null && _timer.isActive) {
                          buttonText = 'start'.tr();
                          _timer.cancel();
                        }
                        saveVisualizationProgress();
                        Future.delayed(const Duration(milliseconds: 300), () {
                          OrderUtil().getRouteById(5).then((value) {
                            Navigator.push(context, value);
                          });
                        });
                      }, () {
                        _timer.cancel();
                        saveVisualizationProgress();
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/start', (r) => false);
                      }, buttonText),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      )),
    );
  }

  int getPassedSeconds() {
    return _startValue - _time;
  }

  void saveVisualizationProgress() {
    if (getPassedSeconds() > 0) {
      VisualizationProgress visualizationProgress =
          VisualizationProgress(getPassedSeconds(), visualizationText);
      Day day = ProgressUtil()
          .createDay(null, null, null, null, null, null, visualizationProgress);
      ProgressUtil().updateDayList(day);
      _time = _startValue;
    }
  }

  Future<bool> _onWillPop() async {
    saveVisualizationProgress();
    if (_timer != null) {
      _timer.cancel();
    }
    return true;
  }

  double createValue() {
    if (_startTime != null) {
      return 1 - _time / (_startTime * 60);
    } else {
      return 0;
    }
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    if (_timer == null || !_timer.isActive) {
      setState(() {
        timerSwitch = true;
        buttonText = 'stop'.tr();
      });
      _timer = Timer.periodic(
          oneSec,
          (Timer timer) => setState(() {
                if (_time < 1) {
                  timer.cancel();
                  saveVisualizationProgress();
                  buttonText = 'start'.tr();
                  OrderUtil().getRouteById(5).then((value) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TimerSuccessScreen(() {
                            Navigator.push(context, value);
                          }),
                        ));
                  });
                } else {
                  _time = _time - 1;
                  print(_time);
                }
              }));
    } else if (_timer != null && _timer.isActive) {
      _timer.cancel();
      setState(() {
        timerSwitch = false;
        buttonText = 'start'.tr();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer.cancel();
    }
  }
}
