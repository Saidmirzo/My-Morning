import 'dart:async';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:hive/hive.dart';
import 'package:just_audio/just_audio.dart';
import 'package:morningmagic/app_states.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/model/affirmation_text/affirmation_text.dart';
import 'package:morningmagic/db/model/book/book.dart';
import 'package:morningmagic/db/model/exercise_time/exercise_time.dart';
import 'package:morningmagic/db/model/progress/affirmation_progress/affirmation_progress.dart';
import 'package:morningmagic/db/model/progress/day/day.dart';
import 'package:morningmagic/db/model/progress/meditation_progress/meditation_progress.dart';
import 'package:morningmagic/db/model/progress/visualization_progress/visualization_progress.dart';
import 'package:morningmagic/db/model/visualization/visualization.dart';
import 'package:morningmagic/db/progress.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/features/meditation_audio/presentation/controller/meditation_audio_controller.dart';
import 'package:morningmagic/pages/paywall_page.dart';
import 'package:morningmagic/pages/progress/progress_page.dart';
import 'package:morningmagic/pages/reading/timer/timer_note_page.dart';
import 'package:morningmagic/pages/success/screenTimerSuccess.dart';
import 'package:morningmagic/routing/app_routing.dart';
import 'package:morningmagic/routing/timer_page_ids.dart';
import 'package:morningmagic/storage.dart';
import 'package:morningmagic/utils/reordering_util.dart';

import 'notifications.dart';

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
    if (pageId != TimerPageId.Reading) saveProgress();
    await OrderUtil().getRouteById(pageId).then((value) {
      print('skipTask pageId: $pageId');
      if (pageId == TimerPageId.Reading)
        getNextPage(value);
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
    if (pageId != TimerPageId.Reading) saveProgress();
  }

  Future<int> getTimeAndText() async {
    Box box = await MyDB().getBox();
    ExerciseTime time =
        box.get(this.getBoxTimeKey(pageId), defaultValue: ExerciseTime(0));
    AffirmationText text = box.get(MyResource.AFFIRMATION_TEXT_KEY,
        defaultValue: AffirmationText(""));
    affirmationText.value = text.affirmationText;
    Visualization visualization =
        box.get(MyResource.VISUALIZATION_KEY, defaultValue: Visualization(""));
    visualizationText = visualization.visualization;
    Book book = box.get(MyResource.BOOK_KEY, defaultValue: Book(""));
    bookTitle = book.bookName;
    return time.time;
  }

  DateTime date = DateTime.now();

  int getPassedSeconds() {
    return startValue - time.value;
  }

  void saveProg(String box, String type, String text) {
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
                  ? '\n$type - ' + 'skip_note'.tr
                  : '\n$type - ${getPassedSeconds()} ' +
                      'seconds'.tr +
                      '($text)'),
          '${date.day}.${date.month}.${date.year}'
        ]);
        list.removeAt(list.indexOf(list.last) - 1);
      } else {
        list.add([
          list.isNotEmpty ? '${(int.parse(list.last[0]) + 1)}' : '0',
          getPassedSeconds() < 5
              ? '\n$type - ' + 'skip_note'.tr
              : '\n$type - ${getPassedSeconds()} ' + 'seconds'.tr + '($text)',
          '${date.day}.${date.month}.${date.year}'
        ]);
      }
    } else {
      list.add([
        list.isNotEmpty ? '${(int.parse(list.last[0]) + 1)}' : '0',
        getPassedSeconds() < 5
            ? '\n$type - ' + 'skip_note'.tr
            : '\n$type - ${getPassedSeconds()} ' + 'seconds'.tr + '($text)',
        '${date.day}.${date.month}.${date.year}'
      ]);
    }
    MyDB().getBox().put(box, list);
  }

  void saveProgress() {
    print('Passed seconds: ${getPassedSeconds()}');
    if (getPassedSeconds() > 0) {
      AffirmationProgress affirmation;
      MeditationProgress meditation;
      VisualizationProgress visualizationProgress;
      // FitnessProgress fitnessProgress;
      switch (pageId) {
        case TimerPageId.Affirmation:
          saveProg(MyResource.AFFIRMATION_PROGRESS, 'affirmation_small'.tr,
              affirmationText.value);
          affirmation =
              AffirmationProgress(getPassedSeconds(), affirmationText.value);
          break;
        case TimerPageId.Meditation:
          meditation = MeditationProgress(getPassedSeconds());
          break;
        case TimerPageId.Fitness:
          saveProg(MyResource.FITNESS_PROGRESS, 'Упражнения', '');
          break;
        case TimerPageId.Reading:
          saveProg(MyResource.MY_READING_PROGRESS, 'Чтение', '');
          break;
        case TimerPageId.Visualization:
          saveProg(MyResource.MY_VISUALISATION_PROGRESS, 'Визуализация', '');
          visualizationProgress =
              VisualizationProgress(getPassedSeconds(), visualizationText);
          break;
        default:
      }

      Day day = ProgressUtil().createDay(affirmation, meditation, null, null,
          null, null, visualizationProgress);
      ProgressUtil().updateDayList(day);
      print('SaveTimerPage id$pageId : $day');
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
          if (pageId != TimerPageId.Reading) saveProgress();
          OrderUtil().getRouteById(pageId).then((value) => getNextPage(value));
          if (onDone != null) onDone();
        } else {
          time.value--;
        }
      });
    } else if (timer != null && timer.isActive) {
      timer.cancel();
      isActive.toggle();
    }
  }

  getNextPage(dynamic value) {
    print('getnextPage fromHomeMenu: $fromHomeMenu');
    print('getNextPage value $value');
    Get.off(pageId == TimerPageId.Reading
        ? TimerInputSuccessScreen(
            fromHomeMenu: fromHomeMenu,
            minutes:
                MyDB().getBox().get(getBoxTimeKey(TimerPageId.Reading)).time)
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
