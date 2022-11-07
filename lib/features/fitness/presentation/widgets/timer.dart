import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/features/fitness/presentation/controller/timer_controller.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/services/timer_left.dart';
import 'package:morningmagic/utils/string_util.dart';
import 'package:morningmagic/widgets/timer_circle_button.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class TimerFitnes extends StatefulWidget {
  final String exerciseName;
  final TimeAppBarState timeAppBarState = TimeAppBarState();

  TimerFitnes({Key key, @required this.exerciseName}) : super(key: key);

  @override
  TimeAppBarState createState() {
    return timeAppBarState;
  }
}

class TimeAppBarState extends State<TimerFitnes> with WidgetsBindingObserver {
  TimerFitnesController cTimer = Get.find();

  TimerLeftController cTimerLeft;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      cTimerLeft.onAppLeft(cTimer.timer, cTimer.time.value,
          onPlayPause: () => cTimer.startStopTimer());
    } else if (state == AppLifecycleState.resumed) {
      cTimerLeft.onAppResume(cTimer.timer, cTimer.time, cTimer.passedSec);
    }
  }

  @override
  void initState() {
    cTimerLeft = TimerLeftController();
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      cTimer.init();
    });
  }

  @override
  void dispose() {
    Get.delete<TimerLeftController>();
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return buildTimerProgress();
  }

  Widget buildTimerProgress() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: Obx(
        () {
          var tm = StringUtil.createTimeString(cTimer.time.value).split(':');
          return Column(
            children: [
              CircularPercentIndicator(
                radius: Get.width / 4,
                lineWidth: 10.0,
                animation: false,
                percent: cTimer.createValue.value,
                center: playPauseBtn(),
                circularStrokeCap: CircularStrokeCap.round,
                linearGradient: AppColors.progressGradientTimerFitness,
                backgroundColor: Colors.white,
              ),
              const SizedBox(
                height: 14.6,
              ),
              Text(
                ' ${tm.first}:${tm.last}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontSize: Get.height * 0.03,
                ),
              ),
            ],
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
          color: AppColors.violet,
        ),
        onPressed: () => cTimer.startStopTimer()));
  }
}
