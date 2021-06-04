import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:morningmagic/db/hive.dart';
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
  AudioPlayer _audioPlayer;
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
    MyDB().getBox().put(
        MyResource.TOTAL_COUNT_OF_SESSIONS,
        MyDB().getBox().get(MyResource.TOTAL_COUNT_OF_SESSIONS) != null
            ? MyDB().getBox().get(MyResource.TOTAL_COUNT_OF_SESSIONS) + 1
            : 1);
    MyDB().getBox().put(
        '${MyResource.MONTH_COUNT_OF_SESSIONS}_${dateTime.month}',
        MyDB().getBox().get(MyResource.MONTH_COUNT_OF_SESSIONS) != null
            ? MyDB().getBox().get(MyResource.MONTH_COUNT_OF_SESSIONS) + 1
            : 1);
    MyDB().getBox().put(
        '${MyResource.YEAR_COUNT_OF_SESSIONS}_${dateTime.year}',
        MyDB().getBox().get(MyResource.YEAR_COUNT_OF_SESSIONS) != null
            ? MyDB().getBox().get(MyResource.YEAR_COUNT_OF_SESSIONS) + 1
            : 1);

    MyDB().getBox().put(
        MyResource.TOTAL_MINUTES_OF_AWARENESS,
        MyDB().getBox().get(MyResource.TOTAL_MINUTES_OF_AWARENESS) != null
            ? MyDB().getBox().get(MyResource.TOTAL_MINUTES_OF_AWARENESS) +
                widget.minutes
            : widget.minutes);
    MyDB().getBox().put(
        '${MyResource.MONTH_MINUTES_OF_AWARENESS}_${dateTime.month}',
        MyDB().getBox().get(MyResource.MONTH_MINUTES_OF_AWARENESS) != null
            ? MyDB().getBox().get(MyResource.MONTH_MINUTES_OF_AWARENESS) +
                widget.minutes
            : widget.minutes);
    MyDB().getBox().put(
        '${MyResource.YEAR_MINUTES_OF_AWARENESS}_${dateTime.year}',
        MyDB().getBox().get(MyResource.YEAR_MINUTES_OF_AWARENESS) != null
            ? MyDB().getBox().get(MyResource.YEAR_MINUTES_OF_AWARENESS) +
                widget.minutes
            : widget.minutes);
    MyDB().getBox().put(
        MyResource.PERCENT_OF_AWARENESS,
        MyDB().getBox().get(MyResource.PERCENT_OF_AWARENESS) != null
            ? MyDB().getBox().get(MyResource.PERCENT_OF_AWARENESS) + 0.5
            : 0.5);

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
