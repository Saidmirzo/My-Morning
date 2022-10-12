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
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        color:
            menuState == MenuState.NIGT ? AppColors.nightModeBG : Colors.white),
    child: SafeArea(
      top: false,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          CupertinoButton(
              child: SvgPicture.asset(
                SvgAssets.timer_night,
                width: btnSize,
                height: btnSize,
              ),
              onPressed: () => Get.to(AddTimePeriod(
                    timerService: timerService,
                  ))),
          CupertinoButton(
              child: SvgPicture.asset(
                SvgAssets.home_night,
                width: btnSize,
                height: btnSize,
              ),
              onPressed: () {
                timerService.goToHome();
              }),
          CupertinoButton(
              child: SvgPicture.asset(
                SvgAssets.skip_night,
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
