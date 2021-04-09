import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/widgets/animatedButton.dart';
import 'package:morningmagic/widgets/custom_progress_bar/arcProgressBar.dart';
import 'package:vibration/vibration.dart';

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
  AudioPlayer _audioPlayer;
  DateTime dateTime = DateTime.now();
  int count;

  String getWeekDay() {
    switch (DateTime.now().weekday) {
      case 1:
        return 'monday';
      case 2:
        return 'tuesday';
      case 3:
        return 'wednesday';
      case 4:
        return 'thursday';
      case 5:
        return 'friday';
      case 6:
        return 'saturday';
      case 7:
        return 'sunday';
    }
  }

  @override
  void initState() {
    super.initState();

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
        MyResource.YEAR_COUNT_OF_SESSIONS,
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
        MyResource.YEAR_MINUTES_OF_AWARENESS,
        MyDB().getBox().get(MyResource.YEAR_MINUTES_OF_AWARENESS) != null
            ? MyDB().getBox().get(MyResource.YEAR_MINUTES_OF_AWARENESS) +
                widget.minutes
            : widget.minutes);
    if (widget.isFinal) {
      MyDB().getBox().put(
          MyResource.TOTAL_COUNT_OF_COMPLETED_SESSIONS,
          MyDB().getBox().get(MyResource.TOTAL_COUNT_OF_COMPLETED_SESSIONS) !=
                  null
              ? MyDB()
                      .getBox()
                      .get(MyResource.TOTAL_COUNT_OF_COMPLETED_SESSIONS) +
                  1
              : 1);
      MyDB().getBox().put(
          '${MyResource.MONTH_COUNT_OF_COMPLETED_SESSIONS}_${dateTime.month}',
          MyDB().getBox().get(MyResource.MONTH_COUNT_OF_COMPLETED_SESSIONS) !=
                  null
              ? MyDB()
                      .getBox()
                      .get(MyResource.MONTH_COUNT_OF_COMPLETED_SESSIONS) +
                  1
              : 1);
      MyDB().getBox().put(
          '${MyResource.YEAR_COUNT_OF_COMPLETED_SESSIONS}_${dateTime.year}',
          MyDB().getBox().get(MyResource.YEAR_COUNT_OF_COMPLETED_SESSIONS) !=
                  null
              ? MyDB()
                      .getBox()
                      .get(MyResource.YEAR_COUNT_OF_COMPLETED_SESSIONS) +
                  1
              : 1);
    }

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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  Future<void> _asyncMethod() async {
    if (await Vibration.hasVibrator()) {
      Vibration.vibrate();
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (_audioPlayer != null) {
      _audioPlayer.stop();
      _audioPlayer.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.TOP_GRADIENT,
              AppColors.MIDDLE_GRADIENT,
              AppColors.BOTTOM_GRADIENT
            ],
          )),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: ArcProgressBar(
                  text: 'success'.tr,
                ),
              ),
              Positioned(
                bottom: MediaQuery.of(context).size.height / 5.5,
                child: AnimatedButton(() async {
                  if (_audioPlayer != null) {
                    _audioPlayer.stop();
                    _audioPlayer.dispose();
                  }
                  widget.onPressed();
                }, 'continue'.tr, 21, null, null),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
