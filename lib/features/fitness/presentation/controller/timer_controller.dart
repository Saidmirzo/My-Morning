import 'dart:async';
import 'dart:developer';

import 'package:flutter_gifimage/flutter_gifimage.dart';
import 'package:get/get.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/model/exercise_time/exercise_time.dart';
import 'package:morningmagic/db/model/progress/fitness_porgress/fitness_progress.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/routing/timer_page_ids.dart';
import 'package:morningmagic/services/progress.dart';

class TimerFitnesController {
  Timer timer;
  int startValue;
  RxInt time = 0.obs;
  String exerciseName = 'NaN';
  // Когда упражнение завершено
  RxBool isExDone = false.obs;
  String progName = '';
  int exerciseCount = 0;
  final Function() onDone;

  GifController gifController;

  DateTime date = DateTime.now();
  String timeStr;

  TimerFitnesController(this.gifController, this.exerciseCount, {this.onDone}) {
    init();
  }

  void init() async {
    print('exerciseCount : $exerciseCount');
    ExerciseTime _time = await MyDB().getBox().get(MyResource.FITNESS_TIME_KEY,
        defaultValue: ExerciseTime(TimerPageId.Fitness));
    var tm = ((_time.time * 60) / exerciseCount).round();
    time.value = tm;
    startValue = tm;
    startStopTimer();
  }

  RxDouble get createValue => startValue != null
      ? (1 - time.value / startValue).toDouble().obs
      : 0.0.obs;

  // Прошло секунд за все упражнения
  RxInt passedSec = 0.obs;

  void saveFitnessProgress(bool isSkip) {
    if (passedSec > 0) {
      var model = FitnessProgress(passedSec.value, progName, exerciseName,
          isSkip: isSkip);
      ProgressController pg = Get.find();
      pg.saveJournal(MyResource.FITNESS_JOURNAL, model);
    }
    time.value = startValue;
    isRuning.value = false;
  }

  RxBool isRuning = false.obs;
  void startStopTimer() {
    if (timer == null || !timer.isActive) {
      isExDone.value = false;
      isRuning.value = true;
      timer = Timer.periodic(
        1.seconds,
        (Timer timer) async {
          if (time.value < 1) {
            timer.cancel();
            saveFitnessProgress(false);
            isExDone.value = true;
            if (onDone != null) onDone();
          } else {
            time--;
            passedSec++;
          }
        },
      );
      log('startTimer');
      gifController?.repeat(min: 0, max: 2, period: 4.seconds);
    } else if (timer != null && timer.isActive) {
      gifController?.stop();
      isRuning.value = false;
      timer.cancel();
    }
  }

  void cancelTimer() {
    timer?.cancel();
    if (!isExDone.value) saveFitnessProgress(true);
    passedSec.value = 0;
  }
}
