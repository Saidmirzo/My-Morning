import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/features/meditation_audio/presentation/controller/meditation_audio_controller.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/services/timer_service.dart';
import 'package:morningmagic/storage.dart';
import 'package:morningmagic/widgets/timer_circle_button.dart';
import 'package:percent_indicator/percent_indicator.dart';

Widget buildTimerProgress(TimerService timerService, bool isSilence) {
  // double _timerSize = Get.width * 0.5;
  MediationAudioController audioController = Get.find();
  if (menuState == MenuState.NIGT) {
    audioController.play();
  }
  return Padding(
    padding: const EdgeInsets.only(top: 54.0, bottom: 16),
    child: Obx(
      () => CircularPercentIndicator(
        radius: Get.width * 0.4,
        lineWidth: 20.0,
        animation: false,
        percent: menuState == MenuState.MORNING ? timerService.createValue : timerService.creatValueNight,
        // percent: 0.5,
        center: TimerCircleButton(
          child: Icon(
            timerService.isActive.isTrue ? Icons.pause : Icons.play_arrow,
            size: 40,
            color: AppColors.violet,
          ),
          onPressed: () {
            print(isSilence);
            if (!isSilence) {
              audioController.playOrPause();
            }
            timerService.startTimer();
          },
        ),
        circularStrokeCap: CircularStrokeCap.round,
        linearGradient: menuState == MenuState.MORNING
            ? AppColors.progressGradientTimerMeditation
            : AppColors.progressGradientTimerMeditationNight,
        backgroundColor: Colors.white,
      ),
    ),
  );
}
