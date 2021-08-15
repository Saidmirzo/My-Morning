import 'dart:async';
import 'dart:developer';

import 'package:flutter_gifimage/flutter_gifimage.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
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

  GifController gifController;

  DateTime date = DateTime.now();
  String timeStr;

  TimerFitnesController(this.gifController) {
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

  // Прошло секунд за все упражнения
  int passedSec = 0;

  void saveFitnessProgress(bool isSkip) {
    if (passedSec > 0) {
      var model =
          FitnessProgress(passedSec, progName, exerciseName, isSkip: isSkip);
      ProgressController pg = Get.find();
      pg.saveJournal(MyResource.FITNESS_JOURNAL, model);
    }
    time.value = startValue;
    isRuning.value = false;
  }

  RxBool isRuning = false.obs;
  void startTimer() {
    if (timer == null || !timer.isActive) {
      isExDone.value = false;
      isRuning.value = true;
      timer = Timer.periodic(
        1.seconds,
        (Timer timer) async {
          if (time.value < 1) {
            timer.cancel();
            final _audioPlayer = AudioPlayer();
            await _audioPlayer.setAsset("assets/audios/success.mp3");
            _audioPlayer.play().then((value) {
              _audioPlayer.dispose();
            });
            saveFitnessProgress(false);
            isExDone.value = true;
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
    saveFitnessProgress(true);
    passedSec = 0;
  }
}
