import 'dart:async';
import 'dart:math';

import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:morningmagic/app_states.dart';
import 'package:morningmagic/can_save.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/model/affirmation_text/affirmation_text.dart';
import 'package:morningmagic/db/model/exercise_time/exercise_time.dart';
import 'package:morningmagic/db/model/progress/affirmation_progress/affirmation_progress.dart';
import 'package:morningmagic/db/model/progress/meditation_progress/meditation_progress.dart';
import 'package:morningmagic/db/model/progress/music_for_cleeping/music_for_skeeping_progress.dart';
import 'package:morningmagic/db/model/visualization/visualization.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/features/instruments_audio/controllers/instruments_audio_controller.dart';
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
import 'package:morningmagic/utils/storage.dart';

import '../pages/custom_methodic/custom_sucsses.dart';

class TimerService {
  Timer timer;
  RxInt constTime = 0.obs;
  int mystateNumber;
  RxInt time = 0.obs;
  int startTime;
  int startValue;
  int pageId;
  RxString affirmationText = ''.obs;
  String visualizationText;
  String bookTitle;
  AppStates appStates = Get.put(AppStates());
  bool fromHomeMenu = false;
  bool resume = false;
  AudioPlayer audioPlayer = AudioPlayer();
  TimerService({this.mystateNumber, this.fromHomeMenu});
  Function onDone;

  init(
    int _pageId, {
    Function onDone,
    int stateNumber,
  }) async {
    if (resume) {
      startTimer();
      resume = false;
      return;
    }
    pageId = _pageId;
    this.onDone = onDone;
    if (startTime == null || startTime == 0) {
      ////////////////////////////////////////////////////////////////////////////
      int value;
      if (pageId == 1 && mystateNumber == 1) {
        value = 300;
      } else if (pageId == 1 && mystateNumber == 2) {
        value = 310;
      } else if (pageId == 1 && mystateNumber == 3) {
        value = 349;
      } else {
        value = await getTimeAndText() * 60;
      }

      // if (value == 0) value = 1;

      time.value = value;
      startValue = value;
      startTime = value;
      constTime.value = startTime;
      startTimer();
    } else {
      time.value = startTime;
      constTime.value = startTime;
      startValue = startTime;

      AffirmationText text = myDbBox.get(
        MyResource.AFFIRMATION_TEXT_KEY,
      );
      affirmationText.value = text?.affirmationText ?? "";
      startTimer();
    }
  }

  dispose() {
    if (timer != null) timer.cancel();
  }

  void nightMeditationStart(Duration duration) {
    if (duration != null) {
      constTime.value = duration.inSeconds;
      time.value = duration.inSeconds;
      // startValue = duration.inSeconds;
      // startTime = duration.inSeconds;
    }
    startTimer();
  }

  double getCircularProcent(int max, int curr) {
    double step1 = max / 100; // 1 %
    double step2 = curr / step1; // how many % has current seconds
    double result = step2 / 100; // for one range from zero
    return result > 1
        ? 1.0
        : result < 0
            ? 0
            : result;
  }

  double get createValue => startTime != null
      ? getCircularProcent(constTime.value, constTime.value - time.value) ?? 0
      : time.toDouble();

  double get creatValueNight => startTime != null
      ? getCircularProcent(constTime.value, constTime.value - time.value) ?? 0
      : time.toDouble();

  void setTime(int min) {
    startTime = min;
    startValue = min;
    constTime.value = min;
    time.value = min;
  }

  void setNightTime(int second) {
    startTime = second;
    startValue = second;
    constTime.value = second;

    time.value = second;
  }

  Future<void> skipTask() async {
    if (timer != null && timer.isActive) {
      timer.cancel();
    }

    if (pageId != TimerPageId.Reading) saveProgress(true);

    await OrderUtil().getRouteById(pageId).then((value) {
      getNextPage(value, true);
    });
    if (pageId == TimerPageId.Meditation) {
      Get.delete<MediationAudioController>();
    }
    if (pageId == TimerPageId.MusicNight) deleteInstrumentAudioController();
  }

  void deleteInstrumentAudioController() {
    InstrumentAudioController _controller = Get.find();
    _controller.dispose();
    Get.delete<InstrumentAudioController>();
  }

  void goToHome() {
    timer?.cancel();
    AppRouting?.navigateToHomeWithClearHistory();
    // При выходе в меню чтение не сохраняем
    if (pageId != TimerPageId.Reading) saveProgress(true);
    if (pageId == TimerPageId.MusicNight) {
      deleteInstrumentAudioController();
    }
  }

  Future<int> getTimeAndText() async {
    ExerciseTime time =
        myDbBox.get(getBoxTimeKey(pageId), defaultValue: ExerciseTime(0));
    AffirmationText text = myDbBox.get(MyResource.AFFIRMATION_TEXT_KEY,
        defaultValue: AffirmationText(""));

    affirmationText.value = text.affirmationText.isEmpty
        ? affiramtions[Random().nextInt(affiramtions.length - 1)]
            .affirmations[Random().nextInt(5)]
            .text
        : text.affirmationText;
    Visualization visualization = myDbBox.get(MyResource.VISUALIZATION_KEY,
        defaultValue: Visualization(""));
    visualizationText = visualization.visualization;
    bookTitle = myDbBox.get(MyResource.BOOK_KEY, defaultValue: '');
    return time.time;
  }

  DateTime date = DateTime.now();

  // Кол-во секунд прошедших со старта таймера
  RxInt passedSec = 0.obs;

  void saveProgress(bool isSkip) {
    if (passedSec > minPassedSec) {
      ProgressController pg = Get.find();
      switch (pageId) {
        case TimerPageId.Affirmation:
          var model = AffirmationProgress(passedSec.value,
              affirmationText.value.isEmpty ? '-' : affirmationText.value,
              isSkip: isSkip);
          pg.saveJournal(MyResource.AFFIRMATION_JOURNAL, model);
          break;
        case TimerPageId.Meditation:
          // Журнал медитаций нигде не показываем, но записываем
          // чтобы потом учитывать в статистике
          var model = MeditationProgress(passedSec.value, isSkip: isSkip);
          pg.saveJournal(MyResource.MEDITATION_JOURNAL, model);
          break;
        case TimerPageId.MeditationNight:
          var model = MeditationProgress(passedSec.value, isSkip: isSkip);
          pg.saveJournal(MyResource.MEDITATION_JOURNAL, model);
          break;
        case TimerPageId.MusicNight:
          deleteInstrumentAudioController();
          var model = MusicForSleepingProgress(passedSec.value, isSkip: isSkip);
          pg.saveJournal(MyResource.MEDITATION_JOURNAL, model);
          break;
        default:
      }

      // Обнуляем время
      time.value = startValue;
    }
  }

  RxBool isActive = false.obs;
  void startTimer() {
    print('START TIMER FUNCTION!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
    const oneSec = Duration(seconds: 1);
    if (timer == null || !timer.isActive) {
      isActive.toggle();

      timer = Timer.periodic(oneSec, (Timer timer) async {
        if (time.value < 1) {
          timer.cancel();
          // if (pageId != TimerPageId.Reading) saveProgress(false);
          if (pageId == TimerPageId.Affirmation) {
            CanSave.changeAffirmation();
          } else if (pageId == TimerPageId.Meditation ||
              pageId == TimerPageId.MeditationNight ||
              pageId == TimerPageId.MusicNight) {
            CanSave.changeMeditation();
          } else if (pageId == TimerPageId.Fitness) {
            CanSave.changeFitness();
          } else if (pageId == TimerPageId.Diary) {
            CanSave.changeDairy();
          } else if (pageId == TimerPageId.Reading) {
            CanSave.changeReading();
          } else if (pageId == TimerPageId.Visualization) {
            CanSave.changeVisualisation();
          } else if (pageId == TimerPageId.Custom1) {
            CanSave.resetSavingModel();
          }

          if (CanSave.canSave) {
            saveProgress(false);
            CanSave.resetSavingModel();
          }

          OrderUtil()
              .getRouteById(pageId)
              .then((value) => getNextPage(value, false));

          if (onDone != null) onDone();
        } else {
          time.value--;
          passedSec++;
        }
      });
    } else if (timer != null && timer.isActive && !resume) {
      timer.cancel();
      isActive.toggle();
    }
  }

  // Время таймера записывается неверно если залочить экран ( passedSeconds )

  getNextPage(dynamic value, bool isSkip, {bool isFinal = false}) {
    Get.off(() =>
    pageId == TimerPageId.Reading
          ? TimerInputSuccessScreen(passedSec.value, isSkip,
              calculateProcent(constTime.value, time.value),
              fromHomeMenu: fromHomeMenu)
          : TimerSuccessScreen(
              () async {
                final _routeValue = await OrderUtil().getRouteById(pageId);
                (pageId == TimerPageId.Custom1 ||
                        pageId == TimerPageId.Custom2 ||
                        pageId == TimerPageId.Custom3 ||
                        pageId == TimerPageId.Custom4)
                    ? Get.off(() => _routeValue)

                    // ? Get.offAll(
                    //     CastomSuccessPage(
                    //       fromHomeMenu: false,
                    //       percentValue: 1,
                    //       pageid: pageId,
                    //     ),
                    //   )}
                    : Get.off(() => fromHomeMenu
                            ? billingService.isVip.value
                                ? const ProgressPage()
                                : PaywallPage()
                            : value,
                      );
              },
              MyDB().getBox().get(getBoxTimeKey(pageId)).time ?? 3,
              isFinal,
              calculateProcent(constTime.value, passedSec.value),
            ),
    );
  }

  double calculateProcent(int maxSeconds, int currentSeconds) {
    double oneProcent = maxSeconds / 100;
    double currProcent = currentSeconds / oneProcent;
    double result = currProcent / 100;
    return result >= 1 ? 1 : result;
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
