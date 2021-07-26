import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/model/progress.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/pages/reading/timer/components/customInputNextColumn.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:vibration/vibration.dart';

import '../../../resources/colors.dart';

class TimerInputSuccessScreen extends StatefulWidget {
  final int minutes;
  final bool fromHomeMenu;

  TimerInputSuccessScreen({this.minutes, this.fromHomeMenu = false});

  @override
  State createState() {
    return TimerInputSuccessScreenState();
  }
}

class TimerInputSuccessScreenState extends State<TimerInputSuccessScreen> {
  AudioPlayer _audioPlayer = AudioPlayer();
  int count;
  DateTime dateTime = DateTime.now();

  String getWeekDay() {
    switch (DateTime.now().weekday) {
      case 1:
        return MyResource.MONDAY;
      case 2:
        return MyResource.TUESDAY;
      case 3:
        return MyResource.WEDNESDAY;
      case 4:
        return MyResource.THUSDAY;
      case 5:
        return MyResource.FRIDAY;
      case 6:
        return MyResource.SATURDAY;
      case 7:
        return MyResource.SUNDAY;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });

    ProgressModel pgModel = MyDB().getProgress();
    pgModel.count_of_session[DateTime.now()] = 1;
    pgModel.minutes_of_awarenes[DateTime.now()] = widget.minutes;
    // Почему-то в старой версии это не сохранялось, скрыл на время и я
    // pgModel.count_of_complete_session[DateTime.now()] = 1;
    pgModel.percent_of_awareness = pgModel.percent_of_awareness + 0.5;
    pgModel.save();

    MyDB().getBox().put(
        getWeekDay(),
        MyDB().getBox().get(getWeekDay()) != null
            ? (MyDB().getBox().get(getWeekDay()) + widget.minutes)
            : widget.minutes);
  }

  Future<void> _asyncMethod() async {
    if (await Vibration.hasVibrator()) {
      Vibration.vibrate();
    }
    await _audioPlayer.setAsset("assets/audios/success.mp3");
    _audioPlayer.play();
  }

  @override
  void dispose() {
    super.dispose();
    dispAudio();
  }

  dispAudio() async {
    if (_audioPlayer != null) {
      await _audioPlayer.stop();
      await _audioPlayer.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Scaffold(
        body: Container(
          width: Get.width,
          height: Get.height,
          decoration:
              BoxDecoration(gradient: AppColors.Bg_Gradient_Timer_Reading),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              bg(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildProgress(context),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: Get.height / 17),
                    child: InputTextColumn(
                      () {
                        dispAudio();
                      },
                      fromHomeMenu: widget.fromHomeMenu,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProgress(BuildContext context) {
    return CircularPercentIndicator(
      radius: Get.height * 0.25,
      lineWidth: 18.0,
      reverse: true,
      animation: false,
      percent: 0.4,
      center: Text(
        'success'.tr,
        style: TextStyle(
            fontSize: Get.height * 0.04,
            fontStyle: FontStyle.normal,
            color: Colors.white,
            fontWeight: FontWeight.w600),
      ),
      circularStrokeCap: CircularStrokeCap.round,
      linearGradient: AppColors.Progress_Gradient_Timer_Reading,
      backgroundColor: Colors.white,
    );
  }

  Positioned bg() {
    return Positioned(
      bottom: 0,
      child: Container(
        width: Get.width,
        child: Image.asset(
          'assets/images/timer/clouds_timer.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    dispAudio();
    return true;
  }
}
