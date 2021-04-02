import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:morningmagic/resources/svg_assets.dart';
import 'package:morningmagic/services/timer_service.dart';

Widget buildMenuButtons(TimerService timerService) {
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
                SvgAssets.home,
                width: btnSize,
                height: btnSize,
              ),
              onPressed: () {
                timerService.goToHome();
              }),
          CupertinoButton(
              child: SvgPicture.asset(
                SvgAssets.forward,
                width: btnSize,
                height: btnSize,
              ),
              onPressed: () {
                timerService.skipTask();
              }),
        ],
      ),
    ),
  );
}
