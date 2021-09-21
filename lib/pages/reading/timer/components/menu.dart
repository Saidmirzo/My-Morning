import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/resources/svg_assets.dart';
import 'package:morningmagic/services/analitics/all.dart';
import 'package:morningmagic/services/timer_service.dart';

import '../../../../storage.dart';
import '../../../add_time_page/add_time_period.dart';

Widget buildMenuButtons(TimerService timerService) {
  double btnSize = 30;
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        color:
            menuState == MenuState.NIGT ? AppColors.nightModeBG : Colors.white),
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
              ),
              onPressed: () => Get.to(AddTimePeriod(
                    timerService: timerService,
                  ))),
          CupertinoButton(
              child: SvgPicture.asset(
                _getIconMenu(SvgAssets.home),
                width: btnSize,
                height: btnSize,
              ),
              onPressed: () {
                timerService.goToHome();
              }),
          CupertinoButton(
              child: SvgPicture.asset(
                _getIconMenu(SvgAssets.forward),
                width: btnSize,
                height: btnSize,
              ),
              onPressed: () {
                timerService.skipTask();
                appAnalitics.logEvent('first_reading_next');
              }),
        ],
      ),
    ),
  );
}

String _getIconMenu(String path) {
  if (menuState == MenuState.MORNING) return path;

  if (menuState == MenuState.NIGT) {
    switch (path) {
      case SvgAssets.home:
        return SvgAssets.home_night;
      case SvgAssets.forward:
        return SvgAssets.skip_night;
      default:
        return SvgAssets.timer_night;
    }
  }
}
