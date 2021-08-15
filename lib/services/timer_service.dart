import 'dart:async';

import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:just_audio/just_audio.dart';
import 'package:morningmagic/app_states.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/model/affirmation_text/affirmation_text.dart';
import 'package:morningmagic/db/model/exercise_time/exercise_time.dart';
import 'package:morningmagic/db/model/progress/affirmation_progress/affirmation_progress.dart';
import 'package:morningmagic/db/model/progress/meditation_progress/meditation_progress.dart';
import 'package:morningmagic/db/model/visualization/visualization.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/features/meditation_audio/presentation/controller/meditation_audio_controller.dart';
import 'package:morningmagic/pages/paywall_page.dart';
import 'package:morningmagic/pages/progress/progress_page.dart';
import 'package:morningmagic/pages/reading/timer/timer_note_page.dart';
import 'package:morningmagic/pages/success/screenTimerSuccess.dart';
import 'package:morningmagic/resources/my_const.dart';
import 'package:morningmagic/routing/app_routing.dart';
import 'package:morningmagic/routing/timer_page_ids.dart';
import 'package:morningmagic/services/progress.dart';
import 'package:morningmagic/storage.dart';
import 'package:morningmagic/utils/reordering_util.dart';

// TODO rewrite
class TimerService {
  Timer timer;
  RxInt time = 0.obs;
  int startTime;
  int startValue;
  int pageId;
  RxString affirmationText = ''.obs;
  String visualizationText;
  String bookTitle;
  AppStates appStates = Get.put(AppStates());
  bool fromHomeMenu = false;

  // TODO remove one of players
  AudioPlayer audioPlayer = AudioPlayer();

  Function onDone;

  init(int _pageId, {Function onDone}) async {
    print('timerService: init');
    this.pageId = _pageId;
    this.onDone = onDone;

    getTimeAndText().then((int value) {
      time.value = value * 60;
      startValue = value * 60;
      startTime = value;
      startTimer();
    });
  }

  dispose() {
    print('Timer cancel');
    if (timer != null) timer.cancel();
  }

  double get createValue =>
      startTime != null ? 1 - time / (startTime * 60) : time.toDouble();

  void setTime(int min) {
    startTime = min;
    startValue = min * 60;
    time.value = min * 60;
  }

  Future<void> skipTask() async {
    if (timer != null && timer.isActive) {
      timer.cancel();
    }
    if (pageId != TimerPageId.Reading) saveProgress(true);
    await OrderUtil().getRouteById(pageId).then((value) {
      print('skipTask pageId: $pageId');
      if (pageId == TimerPageId.Reading)
        getNextPage(value, true);
      else
        Get.off(
          fromHomeMenu
              ? billingService.isVip.value
                  ? ProgressPage()
                  : PaywallPage()
              : value,
        );
    });
    if (pageId == TimerPageId.Meditation) {
      Get.delete<MediationAudioController>();
    }
  }

  Function goToHome() {
    timer?.cancel();
    AppRouting?.navigateToHomeWithClearHistory();
    // При выходе в меню чтение не сохраняем
    if (pageId != TimerPageId.Reading) saveProgress(true);
  }

  Future<int> getTimeAndText() async {
    ExerciseTime time =
        myDbBox.get(this.getBoxTimeKey(pageId), defaultValue: ExerciseTime(0));
    AffirmationText text = myDbBox.get(MyResource.AFFIRMATION_TEXT_KEY,
        defaultValue: AffirmationText(""));
    affirmationText.value = text.affirmationText;
    Visualization visualization = myDbBox.get(MyResource.VISUALIZATION_KEY,
        defaultValue: Visualization(""));
    visualizationText = visualization.visualization;
    bookTitle = myDbBox.get(MyResource.BOOK_KEY, defaultValue: '');
    print('Book title : $bookTitle');
    return time.time;
  }

  DateTime date = DateTime.now();

  // Кол-во секунд прошедших со старта таймера
  int passedSec = 0;

  void saveProgress(bool isSkip) {
    print('saveProgress Passed seconds: $passedSec');
    print('saveProgress isSkip: $isSkip');
    if (passedSec > minPassedSec) {
      ProgressController pg = Get.find();
      switch (pageId) {
        case TimerPageId.Affirmation:
          var model = AffirmationProgress(passedSec,
              affirmationText.value.isEmpty ? '-' : affirmationText.value,
              isSkip: isSkip);
          pg.saveJournal(MyResource.AFFIRMATION_JOURNAL, model);
          break;
        case TimerPageId.Meditation:
          // Журнал медитаций нигде не показываем, но записываем
          // чтобы потом учитывать в статистике
          var model = MeditationProgress(passedSec, isSkip: isSkip);
          pg.saveJournal(MyResource.MEDITATION_JOURNAL, model);
          break;
        default:
      }

      // Обнуляем время
      time.value = startValue;
    } else {
      print('Dont save');
    }
  }

  RxBool isActive = false.obs;
  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    if (timer == null || !timer.isActive) {
      isActive.toggle();
      timer = Timer.periodic(oneSec, (Timer timer) async {
        if (time < 1) {
          print('timer_service: timer work done');
          timer.cancel();
          if (pageId != TimerPageId.Reading) saveProgress(false);
          OrderUtil()
              .getRouteById(pageId)
              .then((value) => getNextPage(value, false));
          if (onDone != null) onDone();
        } else {
          time.value--;
          passedSec++;
        }
      });
    } else if (timer != null && timer.isActive) {
      timer.cancel();
      isActive.toggle();
    }
  }

  getNextPage(dynamic value, bool isSkip) {
    print('getnextPage fromHomeMenu: $fromHomeMenu');
    print('getNextPage value $value');
    Get.off(pageId == TimerPageId.Reading
        ? TimerInputSuccessScreen(passedSec, isSkip, fromHomeMenu: fromHomeMenu)
        : TimerSuccessScreen(
            () => Get.off(
                  fromHomeMenu
                      ? billingService.isVip.value
                          ? ProgressPage()
                          : PaywallPage()
                      : value,
                ),
            MyDB().getBox().get(getBoxTimeKey(pageId)).time ?? 3,
            false));
  }

  getBoxTimeKey(int pageId) {
    switch (pageId) {
      case TimerPageId.Affirmation:
        return MyResource.AFFIRMATION_TIME_KEY;
        break;
      case TimerPageId.Meditation:
        return MyResource.MEDITATION_TIME_KEY;
        break;
      case TimerPageId.Fitness:
        return MyResource.FITNESS_TIME_KEY;
        break;
      case TimerPageId.Reading:
        return MyResource.READING_TIME_KEY;
        break;
      case TimerPageId.Visualization:
        return MyResource.VISUALIZATION_TIME_KEY;
        break;
      default:
        return MyResource.VISUALIZATION_TIME_KEY;
    }
  }
}
