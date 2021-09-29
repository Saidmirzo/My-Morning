import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:morningmagic/features/meditation_audio/presentation/controller/meditation_audio_controller.dart';
import 'package:morningmagic/pages/add_time_page/add_time_period.dart';
import 'package:morningmagic/pages/meditation/meditation_audio_page_night.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/resources/svg_assets.dart';
import 'package:morningmagic/routing/timer_page_ids.dart';
import 'package:morningmagic/services/analitics/all.dart';
import 'package:morningmagic/services/timer_service.dart';
import 'package:morningmagic/storage.dart';

import '../../meditation_audio_page.dart';

Widget buildMenuButtons(TimerService timerService) {
  MediationAudioController cAudio = Get.find();
  double btnSize = 30;
  Color colorIcon = menuState == MenuState.MORNING
      ? AppColors.primary
      : AppColors.purchaseDesc;
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        color: menuState == MenuState.MORNING
            ? Colors.white
            : AppColors.nightModeBG),
    child: SafeArea(
      top: false,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          CupertinoButton(
              child: SvgPicture.asset(
                _getIconMenu(SvgAssets.clock),
                width: btnSize,
                height: btnSize,
                //  color: colorIcon,
              ),
              onPressed: () {
                Get.to(AddTimePeriod(
                  timerService: timerService,
                  pageId: menuState == MenuState.NIGT
                      ? TimerPageId.MeditationNight
                      : -1,
                ));
              }),
          CupertinoButton(
              child: SvgPicture.asset(
                _getIconMenu(SvgAssets.home),
                width: btnSize,
                height: btnSize,
                // color: colorIcon,
              ),
              onPressed: () {
                selIndexNightYoga = 0;
                cAudio.player.pause();
                timerService.goToHome();
              }),
          CupertinoButton(
              child: SvgPicture.asset(
                _getIconMenu(SvgAssets.tiktok_music),
                width: btnSize,
                height: btnSize,
                // color: colorIcon,
              ),
              onPressed: () {
                selIndexNightYoga = 0;
                cAudio.player.pause();
                cAudio.bgAudioPlayer?.value?.pause();
                timerService.timer.cancel();
                timerService.isActive.value = false;
                Get.to(menuState == MenuState.MORNING
                    ? MeditationAudioPage(fromTimerPage: true)
                    : MeditationAudioNightPage(fromTimerPage: true));
              }),
          CupertinoButton(
              child: SvgPicture.asset(
                _getIconMenu(SvgAssets.forward),
                width: btnSize,
                height: btnSize,
                // color: colorIcon,
              ),
              onPressed: () {
                selIndexNightYoga = 0;
                cAudio.player.pause();
                timerService.skipTask();
                appAnalitics.logEvent('first_meditation_next');
              }),
        ],
      ),
    ),
  );
}

String _getIconMenu(value) {
  if (menuState == MenuState.MORNING)
    switch (value) {
      case SvgAssets.home:
        return SvgAssets.home;
      case SvgAssets.tiktok_music:
        return SvgAssets.tiktok_music;
      case SvgAssets.forward:
        return SvgAssets.forward;
      default:
        return SvgAssets.clock;
    }

  if (menuState == MenuState.NIGT)
    switch (value) {
      case SvgAssets.home:
        return SvgAssets.home_night;
      case SvgAssets.tiktok_music:
        return SvgAssets.music_list_night;
      case SvgAssets.forward:
        return SvgAssets.skip_night;
      default:
        return SvgAssets.timer_night;
    }
}
