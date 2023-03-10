import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:morningmagic/pages/add_time_page/add_time_period.dart';
import 'package:morningmagic/pages/affirmation/affirmation_dialog/affirmation_dialog.dart';
import 'package:morningmagic/resources/svg_assets.dart';
import 'package:morningmagic/services/analitics/all.dart';
import 'package:morningmagic/services/timer_service.dart';

Widget buildMenuButtons(TimerService timerService) {
  double btnSize = 30;
  return Container(
    decoration: const BoxDecoration(
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
                  Get.to(() => AddTimePeriod(timerService: timerService))),
          CupertinoButton(
              child: SvgPicture.asset(
                SvgAssets.home,
                width: btnSize,
                height: btnSize,
              ),
              onPressed: () {
                timerService.goToHome();
              }),
          CupertinoButton(
              child: SvgPicture.asset(
                SvgAssets.clouds_done,
                width: btnSize,
                height: btnSize,
              ),
              onPressed: () async {
                final _affirmation =
                    await Get.dialog(const AffirmationCategoryDialog());
                if (_affirmation != null)
                  timerService.affirmationText.value = _affirmation.toString();
              }),
          CupertinoButton(
            child: SvgPicture.asset(
              SvgAssets.forward,
              width: btnSize,
              height: btnSize,
            ),
            onPressed: () async {
              await timerService.skipTask();
              appAnalitics.logEvent('first_affirmation_next');
            },
          ),
        ],
      ),
    ),
  );
}
