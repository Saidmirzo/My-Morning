import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/model/exercise_time/exercise_time.dart';
import 'package:morningmagic/db/model/note/note.dart';
import 'package:morningmagic/db/model/progress/diary_progress/diary_note_progress.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/pages/diary/diary_page.dart';
import 'package:morningmagic/pages/progress/progress_page.dart';
import 'package:morningmagic/pages/success/screenTimerSuccess.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/routing/timer_page_ids.dart';
import 'package:morningmagic/services/analitics/all.dart';
import 'package:morningmagic/services/analitics/analyticService.dart';
import 'package:morningmagic/services/progress.dart';
import 'package:morningmagic/utils/reordering_util.dart';
import 'package:morningmagic/utils/string_util.dart';
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
  DateTime date = DateTime.now();
  int _startTime = 0;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    passedSec = 0;
    initEditText();
    initTimer();
    super.initState();
    // initTimer();
    AnalyticService.screenView('text_note_page');
  }

  void initEditText() {
    textEditingController = TextEditingController();
    textEditingController.addListener(() async {
      if (textEditingController.text != null &&
          textEditingController.text.isNotEmpty) {
        await MyDB()
            .getBox()
            .put(MyResource.NOTE_KEY, Note(textEditingController.text));
      }
    });
  }

  int passedSec = 0;
  void saveNoteProgress(bool isSkip) {
    if (textEditingController.text != null &&
        textEditingController.text.isNotEmpty) {
      var model =
          DiaryNoteProgress(textEditingController.text, passedSec, isSkip);
      ProgressController pg = Get.find();
      pg.saveDiaryJournal(model);
    }
  }

  RxBool isActive = false.obs;
  final RxInt _time = 0.obs;
  Timer _timer;
  void startTimer() async {
    print('startTimer');
    if (_timer == null || !_timer.isActive) {
      isActive.toggle();
      _timer = Timer.periodic(
          1.seconds,
          (Timer timer) => setState(() {
                if (_time.value < 1) {
                  next(false);
                } else {
                  _time?.value--;
                  passedSec++;
                }
              }));
    } else if (_timer != null && _timer.isActive) {
      isActive.toggle();
      _timer.cancel();
    }
  }

  void next(bool isSkip) async {
    if (_timer?.isActive ?? false) _timer.cancel();
    final _audioPlayer = AudioPlayer();
    await _audioPlayer.setAsset("assets/audios/success.mp3");
    saveNoteProgress(isSkip);
    OrderUtil().getRouteById(TimerPageId.Diary).then((value) {
      Get.off(TimerSuccessScreen(() {
        Get.off(widget.fromHomeMenu ? const ProgressPage() : value);
      }, MyDB().getBox().get(MyResource.DIARY_TIME_KEY).time, false, 1));
    });
    appAnalitics.logEvent('first_dnevnik_next');
  }

  void initTimer() {
    ExerciseTime time = MyDB()
        .getBox()
        .get(MyResource.DIARY_TIME_KEY, defaultValue: ExerciseTime(1));
    _time.value = 60;
    _startTime = time.time;
    startTimer();
  }

  RxDouble get leftTime =>
      _startTime != null ? (1 - _time.value / (_startTime * 60)).obs : 0.obs;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: Get.focusScope.unfocus,
      child: WillPopScope(
        onWillPop: () => _onWillPop(),
        child: Scaffold(
          body: Container(
            width: double.maxFinite,
            height: double.maxFinite,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/diary_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Stack(
                children: [
                  // Positioned(
                  //   bottom: 0,
                  //   child: SizedBox(
                  //     width: Get.width,
                  //     child: Image.asset(
                  //       'assets/images/diary/note/clouds.png',
                  //       fit: BoxFit.cover,
                  //     ),
                  //   ),
                  // ),
                  // Positioned(
                  //   bottom: 0,
                  //   child: SizedBox(
                  //     width: Get.width,
                  //     child: Image.asset(
                  //       'assets/images/diary/note/main.png',
                  //       fit: BoxFit.cover,
                  //     ),
                  //   ),
                  // ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 38),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 29,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Get.off(const DiaryPage(), opaque: true);
                                  _timer?.cancel();
                                },
                                child: const Icon(
                                  Icons.west,
                                  size: 30,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: Get.height * 0.05),
                          buildTitle(), ///////////////////////////////////////////
                          const SizedBox(height: 20),
                          // buildTimerProgress(),
                          // const SizedBox(height: 10),
                          // timerText(),
                          const SizedBox(height: 25),
                          Expanded(child: buildInput(context)),
                          const SizedBox(height: 15),
                          nextBtn(),
                          const SizedBox(height: 15),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
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
    return GestureDetector(
      onTap: () => next(true),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          color: const Color(0xff592F72),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Save note'.tr,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ],
        ),
      ),
    );
    // return PrimaryCircleButton(
    //   icon: const Icon(Icons.arrow_forward, color: AppColors.primary),
    //   onPressed: () => next(true),
    // );
  }

  Container buildInput(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.white.withOpacity(0.4),
      ),
      child: Container(
        padding: const EdgeInsets.all(19),
        child: TextField(
          controller: textEditingController,
          minLines: 10,
          maxLines: 10,
          cursorColor: AppColors.VIOLET,
          // keyboardType: TextInputType.text,
          textInputAction: TextInputAction.newline,
          textAlign: TextAlign.left,
          style: TextStyle(
              fontSize: Get.height * 0.02,
              fontStyle: FontStyle.normal,
              color: AppColors.VIOLET,
              decoration: TextDecoration.none),
          decoration: InputDecoration.collapsed(
            hintText: 'Write something here..'.tr,
          ),
        ),
      ),
    );
  }

  Text buildTitle() {
    return Text(
      'diary'.tr,
      style: TextStyle(
        fontSize: Get.height * 0.035,
        fontStyle: FontStyle.normal,
        color: AppColors.WHITE,
      ),
    );
  }

  Future<bool> _onWillPop() async {
    saveNoteProgress(true);
    _timer?.cancel();
    return true;
  }
}
