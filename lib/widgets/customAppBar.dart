import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/model/exercise_time/exercise_time.dart';
import 'package:morningmagic/db/model/progress/day/day.dart';
import 'package:morningmagic/db/model/progress/fitness_porgress/fitness_progress.dart';
import 'package:morningmagic/db/progress.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/features/fitness/presentation/controller/fitness_controller.dart';
import 'package:morningmagic/features/fitness/presentation/pages/exercise_page.dart';
import 'package:morningmagic/features/fitness/presentation/pages/fitness_success_page.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/utils/string_util.dart';

Timer timer;

class TimerAppBar extends StatefulWidget {
  final String exerciseName;
  final TimeAppBarState timeAppBarState = TimeAppBarState();

  TimerAppBar({@required this.exerciseName});

  @override
  TimeAppBarState createState() {
    return timeAppBarState;
  }

  void cancelTimer() {
    timer.cancel();
    timeAppBarState.saveFitnessProgress();
  }
}

class TimeAppBarState extends State<TimerAppBar> {
  int _time;
  int _startValue;
  DateTime date = DateTime.now();
  FitnessController _fitnessController = Get.find<FitnessController>();
  bool isExerciseComplete = false;

  String time;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ExerciseTime time = await MyDB()
          .getBox()
          .get(MyResource.FITNESS_TIME_KEY, defaultValue: ExerciseTime(3));
      _time = time.time * 60;
      _startValue = time.time * 60;
      print('timer start value = $_startValue');
      startTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Container(
          color: AppColors.VIOLET,
        ),
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 30, bottom: 5),
                child: Text(
                  'timer'.tr(),
                  style: TextStyle(
                      color: AppColors.WHITE,
                      fontSize: 14,
                      fontFamily: "rex",
                      fontStyle: FontStyle.normal),
                ),
              ),
              Text(
                StringUtil().createTimeAppBarString(_time),
                style: TextStyle(
                    color: AppColors.WHITE,
                    fontSize: 27,
                    fontFamily: "aparaj",
                    fontStyle: FontStyle.normal),
              ),
              isExerciseComplete
                  ? Container(
                      child: Text(
                        'exercise_complete'.tr(),
                        style: TextStyle(
                            color: AppColors.WHITE,
                            fontSize: 14,
                            fontFamily: "rex",
                            fontStyle: FontStyle.normal),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ],
    );
  }

  int getPassedSeconds() {
    int result = _startValue - _time;
    if (_startValue != null && _time != null) {
      result = _startValue - _time;
    }
    return result;
  }

  void saveProg(String box, String type, String name) {
    List<dynamic> tempList;
    List<dynamic> list = MyDB().getBox().get(box) ?? [];
    tempList = list;
    print(list);
    print(tempList);
    if (list.isNotEmpty) {
      if (list.last[2] == '${date.day}.${date.month}.${date.year}') {
        list.add([
          tempList.isNotEmpty ? '${(int.parse(tempList.last[0]) + 1)}' : '0',
          tempList[tempList.indexOf(tempList.last)][1] +
              (getPassedSeconds() < 5
                  ? '\n$type - ' + 'skip_note'.tr() + '($name)'
                  : '\n$type - ${getPassedSeconds()} ' +
                      'seconds'.tr() +
                      '($name)'),
          '${date.day}.${date.month}.${date.year}'
        ]);
        list.removeAt(list.indexOf(list.last) - 1);
      } else {
        list.add([
          list.isNotEmpty ? '${(int.parse(list.last[0]) + 1)}' : '0',
          getPassedSeconds() < 5
              ? '\n$type - ' + 'skip_note'.tr() + '($name)'
              : '\n$type - ${getPassedSeconds()} ' + 'seconds'.tr() + '($name)',
          '${date.day}.${date.month}.${date.year}'
        ]);
      }
    } else {
      list.add([
        list.isNotEmpty ? '${(int.parse(list.last[0]) + 1)}' : '0',
        getPassedSeconds() < 5
            ? '\n$type - ' + 'skip_note'.tr() + '($name)'
            : '\n$type - ${getPassedSeconds()} ' + 'seconds'.tr() + '($name)',
        '${date.day}.${date.month}.${date.year}'
      ]);
    }
    MyDB().getBox().put(box, list);
  }

  void saveFitnessProgress() {
    if (getPassedSeconds() > 0) {
      FitnessProgress fitness =
          FitnessProgress(getPassedSeconds(), widget.exerciseName);
      saveProg('my_fitness_progress', 'exercises_note'.tr(),
          widget.exerciseName.tr());
      Day day =
          ProgressUtil().createDay(null, null, fitness, null, null, null, null);
      ProgressUtil().updateDayList(day);
      _time = _startValue;
    } else {}
  }

  //need refactoring
  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    if (timer == null || !timer.isActive) {
      timer = Timer.periodic(
          oneSec,
          (Timer timer) => setState(() {
                if (_time < 1) {
                  AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
                  assetsAudioPlayer.open(Audio("assets/audios/success.mp3"));
                  assetsAudioPlayer.play();
                  setState(() {
                    isExerciseComplete = true;
                  });
                  timer.cancel();
                  saveFitnessProgress();
                } else {
                  _time = _time - 1;
                  print(_time);
                }
              }));
    } else if (timer != null && timer.isActive) {
      timer.cancel();
    }
  }

  void cancelTimer() {
    if (timer != null) {
      timer.cancel();
    }
  }
}
