import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/services/timer_service.dart';
import 'package:morningmagic/widgets/timer_circle_button.dart';
import 'package:percent_indicator/percent_indicator.dart';

Widget buildTimerProgress(TimerService timerService) {
  return Padding(
    padding: const EdgeInsets.only(top: 54.0, bottom: 16),
    child: Obx(
      () => CircularPercentIndicator(
        radius: Get.height * 0.18,
        lineWidth: 15.0,
        animation: false,
        percent: timerService.createValue > 1.0 ? 1 : timerService.createValue,
        center: TimerCircleButton(
            child: Icon(
              timerService.isActive.isTrue ? Icons.pause : Icons.play_arrow,
              size: 40,
              color: AppColors.violet,
            ),
            onPressed: () => timerService.startTimer()),
        circularStrokeCap: CircularStrokeCap.round,
        linearGradient: AppColors.progressGradientTimerAffirmation,
        backgroundColor: Colors.white,
      ),
    ),
  );
}
