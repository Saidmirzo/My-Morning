import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/model/exercise_time/exercise_time.dart';
import 'package:morningmagic/db/model/note/note.dart';
import 'package:morningmagic/db/model/progress/day/day.dart';
import 'package:morningmagic/db/model/progress/vocabulary_progress/vocabulary_note_progress.dart';
import 'package:morningmagic/db/progress.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/pages/progress/progress_page.dart';
import 'package:morningmagic/pages/success/screenTimerSuccess.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/routing/timer_page_ids.dart';
import 'package:morningmagic/services/analitics/all.dart';
import 'package:morningmagic/services/analitics/analyticService.dart';
import 'package:morningmagic/utils/reordering_util.dart';
import 'package:morningmagic/utils/string_util.dart';
import 'package:morningmagic/widgets/primary_circle_button.dart';
import 'package:morningmagic/widgets/timer_circle_button.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class TimerNotePage extends StatefulWidget {
  final bool fromHomeMenu;

  const TimerNotePage({Key key, this.fromHomeMenu = false}) : super(key: key);

  @override
  State createState() {
    return TimerNotePageState();
  }
}

class TimerNotePageState extends State<TimerNotePage> {
  TextEditingController textEditingController;
  int count;
  DateTime date = DateTime.now();
  int _startTime = 0;

  @override
  void initState() {
    initEditText();
    super.initState();
    count = MyDB().getBox().get(MyResource.NOTE_COUNT) ?? 0;
    Future.delayed(Duration(days: 1), () {
      MyDB().getBox().put(MyResource.NOTE_COUNT, 0);
    });
    initTimer();
    AnalyticService.screenView('text_note_page');
  }

  void initEditText() {
    textEditingController = new TextEditingController();
    textEditingController.addListener(() async {
      if (textEditingController.text != null &&
          textEditingController.text.isNotEmpty) {
        await MyDB()
            .getBox()
            .put(MyResource.NOTE_KEY, Note(textEditingController.text));
      }
    });
  }

  void saveProg(String box, String path) {
    DateTime date = DateTime.now();
    List<dynamic> list = MyDB().getBox().get(box) ?? [];
    setState(() {
      list.add([
        list.isNotEmpty ? (int.parse(list.last[0]) + 1).toString() : '0',
        path,
        '${date.day}.${date.month}.${date.year}',
      ]);
    });
    MyDB().getBox().put(box, list);
  }

  void saveNoteProgress() {
    if (textEditingController.text != null &&
        textEditingController.text.isNotEmpty) {
      VocabularyNoteProgress noteProgress =
          VocabularyNoteProgress(textEditingController.text);
      saveProg(MyResource.NOTEPADS, noteProgress.note);
      Day day = ProgressUtil()
          .createDay(null, null, null, null, noteProgress, null, null);
      ProgressUtil().updateDayList(day);
    }
  }

  RxBool isActive = false.obs;
  RxInt _time = 0.obs;
  Timer _timer;
  void startTimer() async {
    print('startTimer');
    if (_timer == null || !_timer.isActive) {
      isActive.toggle();
      _timer = Timer.periodic(
          1.seconds,
          (Timer timer) => setState(() {
                if (_time.value < 1) {
                  next();
                } else {
                  _time.value--;
                }
              }));
    } else if (_timer != null && _timer.isActive) {
      isActive.toggle();
      _timer.cancel();
    }
  }

  void next() async {
    if (_timer?.isActive ?? false) _timer.cancel();
    final _audioPlayer = AudioPlayer();
    await _audioPlayer.setAsset("assets/audios/success.mp3");
    saveNoteProgress();
    OrderUtil().getRouteById(TimerPageId.Diary).then((value) {
      Get.off(TimerSuccessScreen(() {
        Get.off(widget.fromHomeMenu ? ProgressPage() : value);
      }, MyDB().getBox().get(MyResource.DIARY_TIME_KEY).time, false));
    });
    appAnalitics.logEvent('first_dnevnik_next');
  }

  void initTimer() {
    ExerciseTime time = MyDB().getBox().get(MyResource.DIARY_TIME_KEY,
        defaultValue: ExerciseTime(TimerPageId.Diary));
    _time.value = time.time * 60;
    _startTime = time.time;
    startTimer();
  }

  RxDouble get leftTime =>
      _startTime != null ? (1 - _time.value / (_startTime * 60)).obs : 0.obs;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Scaffold(
        body: Container(
          width: Get.width,
          height: Get.height,
          decoration: BoxDecoration(
            gradient: AppColors.Bg_Gradient_Timer_Diary_Note,
          ),
          child: SafeArea(
            bottom: false,
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: Get.width,
                    child: Image.asset(
                      'assets/images/diary/note/clouds.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: Get.width,
                    child: Image.asset(
                      'assets/images/diary/note/main.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 38),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(height: Get.height * 0.05),
                      buildTitle(),
                      const SizedBox(height: 20),
                      buildTimerProgress(),
                      const SizedBox(height: 10),
                      timerText(),
                      const SizedBox(height: 25),
                      buildInput(context),
                      const SizedBox(height: 15),
                      nextBtn(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTimerProgress() {
    return Obx(
      () => CircularPercentIndicator(
        radius: 90,
        lineWidth: 7.0,
        animation: false,
        percent: leftTime.value,
        center: TimerCircleButton(
          child: Icon(
            isActive.isTrue ? Icons.pause : Icons.play_arrow,
            size: 20,
            color: AppColors.VIOLET,
          ),
          onPressed: startTimer,
        ),
        circularStrokeCap: CircularStrokeCap.round,
        linearGradient: AppColors.Progress_Gradient_Timer_Affirmation,
        backgroundColor: Colors.white,
      ),
    );
  }

  Widget timerText() {
    return Obx(
      () => Text(
        StringUtil.createTimeString(_time.value),
        style: TextStyle(
          fontSize: Get.height * 0.02,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
        ),
      ),
    );
  }

  Widget nextBtn() {
    return PrimaryCircleButton(
      icon: Icon(Icons.arrow_forward, color: AppColors.primary),
      onPressed: () => next(),
    );
  }

  Container buildInput(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.white.withOpacity(0.4),
      ),
      child: Container(
        padding: EdgeInsets.all(19),
        child: TextField(
          controller: textEditingController,
          minLines: 10,
          maxLines: 10,
          cursorColor: AppColors.VIOLET,
          keyboardType: TextInputType.text,
          textAlign: TextAlign.left,
          style: TextStyle(
              fontSize: Get.height * 0.02,
              fontStyle: FontStyle.normal,
              color: AppColors.VIOLET,
              decoration: TextDecoration.none),
          decoration: null,
        ),
      ),
    );
  }

  Text buildTitle() {
    return Text(
      'note'.tr,
      style: TextStyle(
        fontSize: Get.height * 0.035,
        fontStyle: FontStyle.normal,
        color: AppColors.WHITE,
      ),
    );
  }

  Future<bool> _onWillPop() async {
    saveNoteProgress();
    return true;
  }
}
