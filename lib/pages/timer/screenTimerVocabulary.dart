import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/model/exercise_time/exercise_time.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/pages/success/screenTimerRecordSuccess.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/utils/reordering_util.dart';
import 'package:morningmagic/utils/string_util.dart';
import 'package:morningmagic/widgets/customStartSkipColumn.dart';
import 'package:morningmagic/widgets/custom_progress_bar/circleProgressBar.dart';

import 'package:easy_localization/easy_localization.dart';

class TimerVocabularyScreen extends StatefulWidget {
  @override
  State createState() {
    return TimerVocabularyScreenState();
  }
}

class TimerVocabularyScreenState extends State<TimerVocabularyScreen> {
  Timer _timer;
  int _time;
  int _startTime;
  String buttonText;

  AudioPlayer audioPlayer;

  bool isInitialized = false;

  Future<Box> getBox() async {
    return await MyDB().getBox();
  }

  @override
  void initState() {
    getBox().then((Box box) {
      setState(() {
        ExerciseTime time = box.get(MyResource.VOCABULARY_TIME_KEY, defaultValue: ExerciseTime(3));
        _time = time.time * 60;
        _startTime = time.time;
        startTimer();
      });
    });
    print('экран таймера дневника');
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 3.3),
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
                        OrderUtil().getRouteById(3).then((value) {
                          Navigator.push(context, value);
                        });
                      }, () {
                        _timer.cancel();
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

  Future<bool> _onWillPop() async {
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

  void startTimer() async {
    const oneSec = const Duration(seconds: 1);
    if (_timer == null || !_timer.isActive) {
      setState(() {
        buttonText = 'stop'.tr();
      });

      _timer = Timer.periodic(
          oneSec,
          (Timer timer) => setState(() {
                if (_time < 1) {
                  timer.cancel();
                  buttonText = 'start'.tr();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TimerRecordSuccessScreen(),
                      ));
                } else {
                  _time = _time - 1;
                  print(_time);
                }
              }));
    } else if (_timer != null && _timer.isActive) {
      _timer.cancel();
      setState(() {
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
