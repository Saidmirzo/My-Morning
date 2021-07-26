import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/model/progress.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:vibration/vibration.dart';

import '../../widgets/primary_circle_button.dart';

class TimerSuccessScreen extends StatefulWidget {
  final VoidCallback onPressed;
  final int minutes;
  final bool isFinal;

  TimerSuccessScreen(this.onPressed, this.minutes, this.isFinal);

  @override
  State createState() {
    return TimerSuccessScreenState();
  }
}

class TimerSuccessScreenState extends State<TimerSuccessScreen> {
  AudioPlayer _audioPlayer = AudioPlayer();
  DateTime dateTime = DateTime.now();
  int count;

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
      default:
        return 'unknown day';
    }
  }

  @override
  void initState() {
    super.initState();

    ProgressModel pgModel = MyDB().getProgress();

    pgModel.count_of_session[DateTime.now()] = 1;
    pgModel.minutes_of_awarenes[DateTime.now()] = widget.minutes;
    if (widget.isFinal) {
      pgModel.count_of_complete_session[DateTime.now()] = 1;
    }
    pgModel.percent_of_awareness = pgModel.percent_of_awareness + 0.5;

    pgModel.save();

    MyDB().getBox().put(getWeekDay(),
        MyDB().getBox().get(getWeekDay(), defaultValue: 0) + widget.minutes);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  Future<void> _asyncMethod() async {
    if (await Vibration.hasVibrator()) {
      Vibration.vibrate();
    }
    await _audioPlayer.setAsset("assets/audios/success.mp3");
    await _audioPlayer.play();
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
    return Scaffold(
      body: Center(
        child: Container(
          width: Get.width,
          height: Get.height,
          decoration:
              BoxDecoration(gradient: AppColors.Bg_Gradient_Timer_Reading),
          child: Stack(
            alignment: Alignment.center,
            children: [
              bg(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildProgress(),
                  SizedBox(height: 20),
                  const SizedBox(height: 50),
                  buildButton(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButton() {
    return PrimaryCircleButton(
      size: 45,
      icon: Icon(Icons.arrow_forward, color: AppColors.primary),
      onPressed: () {
        if (_audioPlayer != null) {
          _audioPlayer.stop();
          _audioPlayer.dispose();
        }
        widget.onPressed();
      },
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

  Widget buildProgress() {
    return CircularPercentIndicator(
      radius: Get.height * 0.35,
      lineWidth: 27.0,
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
}
