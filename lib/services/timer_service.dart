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
import 'package:morningmagic/pages/reading/timer/timer_note_page.dart';
import 'package:morningmagic/pages/success/screenTimerSuccess.dart';
import 'package:morningmagic/routing/app_routing.dart';
import 'package:morningmagic/routing/timer_page_ids.dart';
import 'package:morningmagic/utils/reordering_util.dart';

import 'notifications.dart';

// TODO rewrite
class TimerService {
  Timer timer;
  RxInt _time = 0.obs;
  int get time => _time.value;
  int startTime;
  int startValue;
  int pageId;
  RxString affirmationText = ''.obs;
  String visualizationText;
  String bookTitle;
  AppStates appStates = Get.put(AppStates());

  DateTime appLeftTime;
  int leftSecondsBeforePauseApp = 0;

  // TODO remove one of players
  AudioPlayer audioPlayer = AudioPlayer();
  AudioPlayer _player;

  init(int _pageId, AudioPlayer _player) async {
    print('timerService: init');
    this.pageId = _pageId;
    this._player = _player;

    getTimeAndText().then((int value) {
      _time.value = value * 60;
      startValue = value * 60;
      startTime = value;
      startTimer();
    });
  }

  dispose() {
    print('Timer cancel');
    if (timer != null) timer.cancel();
  }

  Future<void> skipTask() async {
    print('skipTask: run');
    if (timer != null && timer.isActive) {
      timer.cancel();
    }
    print('skipTask: 2');
    if (pageId != TimerPageId.Reading) saveProgress();
    print('skipTask: 3');
    await OrderUtil().getRouteById(pageId).then((value) {
      print('skipTask pageId: $pageId');
      if (pageId == TimerPageId.Reading)
        getNextPage(value);
      else
        Get.off(value);
    });
    print('skipTask: 4');
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
    return startValue - time;
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
      _time.value = startValue;
    } else {
      print('Dont save');
    }
  }

  double get createValue =>
      startTime != null ? 1 - time / (startTime * 60) : time.toDouble();

  RxBool isActive = false.obs;
  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    if (timer == null || !timer.isActive) {
      isActive.toggle();
      timer = Timer.periodic(oneSec, (Timer timer) {
        if (time < 1) {
          print('timer_service: timer work done');
          audioPlayer.setAsset("assets/audios/success.mp3");
          audioPlayer.play();
          _player?.stop();
          timer.cancel();
          if (pageId != TimerPageId.Reading) saveProgress();
          OrderUtil().getRouteById(pageId).then((value) => getNextPage(value));
        } else {
          _time.value--;
        }
      });
    } else if (timer != null && timer.isActive) {
      timer.cancel();
      isActive.toggle();
    }
  }

  void onAppLeft() async {
    print('До завершения осталось ${time} c.');
    leftSecondsBeforePauseApp = time;
    // Уведомим о заверщении упражнения через N оставшихся секунд
    if (time > 0 && timer.isActive) {
      appLeftTime = DateTime.now();
      pushNotifications.sendNotificationWithSleep(
          'push_success'.tr, 'action_completed'.tr, time,
          id: PushNotifications.pushIdTreaning);
      if (GetPlatform.isAndroid) {
        // На андроид пуш не показывает на заблокированном экране
        // По этому запустим наш звук завершения, чтобы привлечь внимание
        _startIsolate(time);
      }
    } else {
      print('Пропускаем запуск изолятора т.к. таймер уже неактивен');
    }
  }

  void onAppResume() async {
    int val =
        DateTime.now().difference(appLeftTime ?? DateTime.now()).inSeconds;
    print('Разница: $val сек');
    if (timer.isActive) _time.value = leftSecondsBeforePauseApp - val;
    pushNotifications.deleteNotification(PushNotifications.pushIdTreaning);
    _stopIsolate();
  }

  Isolate _isolate;
  ReceivePort _receivePort;

  void _startIsolate(int tm) async {
    print('Запускаем изолятор');
    _receivePort = ReceivePort();
    _isolate = await Isolate.spawn(
        waitAndNotifyInBg, IsolateData(_receivePort.sendPort, tm));
    _receivePort.listen(_isolateHandleMessage, onDone: () {
      print('onDone');
      // Проверка чтобы не срабатывало уведомление
      // если мы вернулись до окончания таймера и отменили изолятор вручную
      if (_isolate == null) notifyInBackground();
    });
  }

  void notifyInBackground() {
    print('notifyInBackground');
    AudioPlayer audioPlayer = AudioPlayer();
    audioPlayer.setAsset("assets/audios/success.mp3");
    audioPlayer.play();
    _player?.stop();
  }

  static void waitAndNotifyInBg(IsolateData data) async {
    print('leftSecondsBeforePauseApp : ${data.time}');
    Timer.periodic(new Duration(seconds: 5), (Timer t) {
      String msg = 'notification ${DateTime.now()}';
      data.sendPort.send(msg);
    });
  }

  void _isolateHandleMessage(dynamic data) {
    print('RECEIVED: ' + data);
  }

  void _stopIsolate() {
    if (_isolate != null) {
      print('_stopIsolate');
      _receivePort.close();
      _isolate.kill(priority: Isolate.immediate);
      _isolate = null;
    }
  }

  getNextPage(dynamic value) {
    Get.off(pageId == TimerPageId.Reading
        ? TimerInputSuccessScreen(
            minutes:
                MyDB().getBox().get(getBoxTimeKey(TimerPageId.Reading)).time)
        : TimerSuccessScreen(() => Get.to(value),
            MyDB().getBox().get(getBoxTimeKey(pageId)).time ?? 3, false));
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

class IsolateData {
  SendPort sendPort;
  int time;
  IsolateData(this.sendPort, this.time);
}
