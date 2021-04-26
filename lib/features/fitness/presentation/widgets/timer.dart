import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/features/fitness/presentation/controller/timer_controller.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/utils/string_util.dart';
import 'package:morningmagic/widgets/timer_circle_button.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class TimerFitnes extends StatefulWidget {
  final String exerciseName;
  final TimeAppBarState timeAppBarState = TimeAppBarState();

  TimerFitnes({@required this.exerciseName});

  @override
  TimeAppBarState createState() {
    return timeAppBarState;
  }
}

class TimeAppBarState extends State<TimerFitnes> {
  TimerFitnesController cTimer = Get.find();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      cTimer.init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        buildTimerProgress(),
        playPauseBtn(),
      ],
    );
  }

  Widget buildTimerProgress() {
    return Padding(
      padding: const EdgeInsets.only(top: 54.0, bottom: 16),
      child: Obx(
        () {
          var tm = StringUtil.createTimeString(cTimer.time.value).split(':');
          return CircularPercentIndicator(
            radius: Get.height * 0.17,
            lineWidth: 10.0,
            animation: false,
            percent: cTimer.createValue.value,
            center: Text(
              ' ${tm.first}\n${tm.last}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.white,
                fontSize: Get.height * 0.03,
              ),
            ),
            circularStrokeCap: CircularStrokeCap.round,
            linearGradient: AppColors.Progress_Gradient_Timer_Fitnes,
            backgroundColor: Colors.white,
          );
        },
      ),
    );
  }

  Widget playPauseBtn() {
    return Obx(() => TimerCircleButton(
        child: Icon(
          cTimer.isRuning.isTrue ? Icons.pause : Icons.play_arrow,
          size: 25,
          color: AppColors.VIOLET,
        ),
        onPressed: () => cTimer.startTimer()));
  }
}