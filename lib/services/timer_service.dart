import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
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
import 'package:morningmagic/pages/success/screenTimerInputSuccess.dart';
import 'package:morningmagic/pages/success/screenTimerSuccess.dart';
import 'package:morningmagic/routing/routing.dart';
import 'package:morningmagic/utils/reordering_util.dart';

// TODO rewrite
class TimerService {
  BuildContext context;
  State state;
  Timer timer;
  int time;
  int startTime;
  int startValue;
  int pageId;
  String affirmationText;
  String visualizationText;
  String bookTitle;
  String buttonText;
  AppStates appStates = Get.put(AppStates());

  // TODO remove one of players
  AudioPlayer audioPlayer = AudioPlayer();
  AudioPlayer _player;

  init(State _state, BuildContext _context, int _pageId,
      AudioPlayer _player) async {
    this.state = _state;
    this.context = _context;
    this.pageId = _pageId;
    this._player = _player;

    getTimeAndText().then((int value) {
      time = value * 60;
      startValue = value * 60;
      startTime = value;
      startTimer();
    });
  }

  dispose() {
    print('Timer cancel');
    if (timer != null) timer.cancel();
  }

  Function skipTask() {
    if (timer != null && timer.isActive) {
      buttonText = 'start'.tr();
      timer.cancel();
    }
    if (pageId != 4) saveProgress();
    OrderUtil().getRouteById(pageId).then((value) {
      if (pageId == 4)
        getNextPage(value);
      else
        Navigator.push(context, value);
    });

    if (pageId == 1) {
      Get.delete<MediationAudioController>();
    }
  }

  Function goToHome() {
    timer.cancel();
    Routing.navigateToHomeWithClearHistory(context);
    // При выходе в меню чтение (id4) не сохраняем
    if (pageId != 4) saveProgress();
  }

  Future<int> getTimeAndText() async {
    Box box = await MyDB().getBox();
    ExerciseTime time =
        box.get(this.getBoxTimeKey(pageId), defaultValue: ExerciseTime(0));
    AffirmationText text = box.get(MyResource.AFFIRMATION_TEXT_KEY,
        defaultValue: AffirmationText(""));
    affirmationText = text.affirmationText;
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
                  ? '\n$type - ' + 'skip_note'.tr()
                  : '\n$type - ${getPassedSeconds()} ' +
                      'seconds'.tr() +
                      '($text)'),
          '${date.day}.${date.month}.${date.year}'
        ]);
        list.removeAt(list.indexOf(list.last) - 1);
      } else {
        list.add([
          list.isNotEmpty ? '${(int.parse(list.last[0]) + 1)}' : '0',
          getPassedSeconds() < 5
              ? '\n$type - ' + 'skip_note'.tr()
              : '\n$type - ${getPassedSeconds()} ' + 'seconds'.tr() + '($text)',
          '${date.day}.${date.month}.${date.year}'
        ]);
      }
    } else {
      list.add([
        list.isNotEmpty ? '${(int.parse(list.last[0]) + 1)}' : '0',
        getPassedSeconds() < 5
            ? '\n$type - ' + 'skip_note'.tr()
            : '\n$type - ${getPassedSeconds()} ' + 'seconds'.tr() + '($text)',
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
        case 0:
          saveProg(MyResource.AFFIRMATION_PROGRESS, 'affirmation_small'.tr(),
              affirmationText);
          affirmation =
              AffirmationProgress(getPassedSeconds(), affirmationText);
          break;
        case 1:
          meditation = MeditationProgress(getPassedSeconds());
          break;
        case 2:
          saveProg(MyResource.FITNESS_PROGRESS, 'Упражнения', '');
          break;
        case 4:
          saveProg(MyResource.MY_READING_PROGRESS, 'Чтение', '');
          break;
        case 5:
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
      time = startValue;
    } else {
      print('Dont save');
    }
  }

  double createValue() {
    if (startTime != null) {
      return 1 - time / (startTime * 60);
    } else {
      return 0;
    }
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    if (timer == null || !timer.isActive) {
      state.setState(() {
        print('set state');
        buttonText = 'stop'.tr();
      });
      timer = Timer.periodic(
          oneSec,
          (Timer timer) => state.setState(() {
                if (time < 1) {
                  audioPlayer.setAsset("assets/audios/success.mp3");
                  audioPlayer.play();
                  _player?.stop();
                  timer.cancel();
                  if (pageId != 4) saveProgress();
                  buttonText = 'start'.tr();
                  OrderUtil()
                      .getRouteById(pageId)
                      .then((value) => getNextPage(value));
                } else {
                  time = time - 1;
                  // print(time);
                }
              }));
    } else if (timer != null && timer.isActive) {
      timer.cancel();
      state.setState(() {
        buttonText = 'start'.tr();
      });
    }
  }

  getNextPage(Route value) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        if (pageId == 4)
          return TimerInputSuccessScreen(
              minutes: MyDB().getBox().get(getBoxTimeKey(4)).time);
        return TimerSuccessScreen(() => Navigator.push(context, value),
            MyDB().getBox().get(getBoxTimeKey(pageId)).time, false);
      },
    ));
  }

  getBoxTimeKey(int pageId) {
    switch (pageId) {
      case 0:
        return MyResource.AFFIRMATION_TIME_KEY;
        break;
      case 1:
        return MyResource.MEDITATION_TIME_KEY;
        break;
      case 2:
        return MyResource.FITNESS_TIME_KEY;
        break;
      case 4:
        return MyResource.READING_TIME_KEY;
        break;
      case 5:
        return MyResource.VISUALIZATION_TIME_KEY;
        break;
      default:
        return MyResource.VISUALIZATION_TIME_KEY;
    }
  }
}
