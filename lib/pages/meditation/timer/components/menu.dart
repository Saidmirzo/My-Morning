import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:morningmagic/features/meditation_audio/presentation/controller/meditation_audio_controller.dart';
import 'package:morningmagic/pages/add_time_page/add_time_period.dart';
import 'package:morningmagic/resources/svg_assets.dart';
import 'package:morningmagic/services/analitics/all.dart';
import 'package:morningmagic/services/timer_service.dart';

import '../../meditation_audio_page.dart';

Widget buildMenuButtons(TimerService timerService) {
  MediationAudioController cAudio = Get.find();
  double btnSize = 30;
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        color: Colors.white),
    child: SafeArea(
      top: false,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          CupertinoButton(
              child: SvgPicture.asset(
                SvgAssets.clock,
                width: btnSize,
                height: btnSize,
              ),
              onPressed: () =>
                  Get.to(AddTimePeriod(timerService: timerService))),
          CupertinoButton(
              child: SvgPicture.asset(
                SvgAssets.home,
                width: btnSize,
                height: btnSize,
              ),
              onPressed: () {
                cAudio.player.pause();
                timerService.goToHome();
              }),
          CupertinoButton(
              child: SvgPicture.asset(
                SvgAssets.tiktok_music,
                width: btnSize,
                height: btnSize,
              ),
              onPressed: () {
                cAudio.player.pause();
                timerService.timer.cancel();
                timerService.isActive.value = false;
                Get.to(MeditationAudioPage(fromTimerPage: true));
              }),
          CupertinoButton(
              child: SvgPicture.asset(
                SvgAssets.forward,
                width: btnSize,
                height: btnSize,
              ),
              onPressed: () {
                cAudio.player.pause();
                timerService.skipTask();
                appAnalitics.logEvent('first_meditation_next');
              }),
        ],
      ),
    ),
  );
}
