import 'dart:async';

import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/model/exercise_time/exercise_time.dart';
import 'package:morningmagic/db/model/progress/day/day.dart';
import 'package:morningmagic/db/model/progress/fitness_porgress/fitness_progress.dart';
import 'package:morningmagic/db/progress.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/routing/timer_page_ids.dart';

class TimerFitnesController {
  Timer timer;
  int startValue;
  RxInt time = 0.obs;
  String exerciseName = 'NaN';
  // Когда упражнение завершено
  RxBool isExDone = false.obs;

  DateTime date = DateTime.now();
  String timeStr;

  TimerFitnesController() {
    init();
  }

  void init() async {
    ExerciseTime _time = await MyDB().getBox().get(MyResource.FITNESS_TIME_KEY,
        defaultValue: ExerciseTime(TimerPageId.Fitness));
    time.value = _time.time * 60;
    startValue = _time.time * 60;
    startTimer();
  }

  RxDouble get createValue => startValue != null
      ? (1 - time.value / startValue).toDouble().obs
      : 0.0.obs;

  int get getPassedSeconds => startValue != null ? startValue - time.value : 0;

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
              (getPassedSeconds < 5
                  ? '\n$type - ' + 'skip_note'.tr + '($name)'
                  : '\n$type - ${getPassedSeconds} ' +
                      'seconds'.tr +
                      '($name)'),
          '${date.day}.${date.month}.${date.year}'
        ]);
        list.removeAt(list.indexOf(list.last) - 1);
      } else {
        list.add([
          list.isNotEmpty ? '${(int.parse(list.last[0]) + 1)}' : '0',
          getPassedSeconds < 5
              ? '\n$type - ' + 'skip_note'.tr + '($name)'
              : '\n$type - ${getPassedSeconds} ' + 'seconds'.tr + '($name)',
          '${date.day}.${date.month}.${date.year}'
        ]);
      }
    } else {
      list.add([
        list.isNotEmpty ? '${(int.parse(list.last[0]) + 1)}' : '0',
        getPassedSeconds < 5
            ? '\n$type - ' + 'skip_note'.tr + '($name)'
            : '\n$type - ${getPassedSeconds} ' + 'seconds'.tr + '($name)',
        '${date.day}.${date.month}.${date.year}'
      ]);
    }
    MyDB().getBox().put(box, list);
  }

  void saveFitnessProgress() {
    if (getPassedSeconds > 0) {
      print('saveFitnessProgress: passedSeconds>0');
      FitnessProgress fitness = FitnessProgress(getPassedSeconds, exerciseName);
      saveProg(
          MyResource.FITNESS_PROGRESS, 'exercises_note'.tr, exerciseName.tr);
      Day day =
          ProgressUtil().createDay(null, null, fitness, null, null, null, null);
      ProgressUtil().updateDayList(day);
    } else {
      print('saveFitnessProgress: passedSeconds<=0');
    }
    time.value = startValue;
    isRuning.value = false;
    print('saveFitnessProgress: end');
  }

  RxBool isRuning = false.obs;
  void startTimer() {
    if (timer == null || !timer.isActive) {
      isExDone.value = false;
      isRuning.value = true;
      timer = Timer.periodic(
        1.seconds,
        (Timer timer) {
          if (time.value < 1) {
            final _audioPlayer = AudioPlayer();

            _audioPlayer.setAsset("assets/audios/success.mp3");
            _audioPlayer.play();
            timer.cancel();
            saveFitnessProgress();
            isExDone.value = true;
          } else {
            time--;
          }
        },
      );
    } else if (timer != null && timer.isActive) {
      isRuning.value = false;
      timer.cancel();
    }
  }

  void cancelTimer() {
    timer?.cancel();
    saveFitnessProgress();
  }
}
