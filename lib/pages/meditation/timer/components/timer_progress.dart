import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/features/meditation_audio/presentation/controller/meditation_audio_controller.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/services/timer_service.dart';
import 'package:morningmagic/storage.dart';
import 'package:morningmagic/widgets/timer_circle_button.dart';
import 'package:percent_indicator/percent_indicator.dart';

Widget buildTimerProgress(TimerService timerService, bool isSilence) {
  double _timerSize = Get.width * 0.5;
  MediationAudioController audioController = Get.find();

  return Padding(
    padding: const EdgeInsets.only(top: 54.0, bottom: 16),
    child: Obx(
      () => CircularPercentIndicator(
        radius: Get.height * 0.24,
        lineWidth: 20.0,
        animation: false,
        percent: menuState == MenuState.MORNING ? timerService.createValue : timerService.creatValueNight,
        center: TimerCircleButton(
          child: Icon(
            timerService.isActive.isTrue ? Icons.pause : Icons.play_arrow,
            size: 40,
            color: AppColors.VIOLET,
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
        linearGradient: menuState == MenuState.MORNING ? AppColors.Progress_Gradient_Timer_Meditation : AppColors.Progress_Gradient_Timer_Meditation_Night,
        backgroundColor: Colors.white,
      ),
    ),
  );
}
