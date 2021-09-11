import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:morningmagic/pages/menu/main_menu.dart';
import 'package:morningmagic/pages/nigth/nigth.dart';
import 'package:morningmagic/pages/progress/progress_page.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/resources/svg_assets.dart';
import 'package:morningmagic/services/analitics/all.dart';

import '../../faq/faq_menu.dart';

class BottomMenu extends StatelessWidget {
  final double btnSize = 30;
  Color bgColor;

  BottomMenu({this.bgColor = AppColors.WHITE});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      color: Colors.transparent,
      child: Container(
        width: Get.width,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.05),
                spreadRadius: 3,
                blurRadius: 5,
              ),
            ],
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            color: this.bgColor),
        child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _menuButton(SvgAssets.microphone,
                  onPress: _openMorning,
                  color: this.bgColor == AppColors.WHITE
                      ? AppColors.primary
                      : AppColors.WHITE),
              _menuButton(SvgAssets.clock,
                  onPress: _openNight,
                  color: this.bgColor == AppColors.WHITE
                      ? AppColors.primary
                      : AppColors.WHITE),
              _menuButton(SvgAssets.progress,
                  onPress: _openProgress,
                  color: this.bgColor == AppColors.WHITE
                      ? AppColors.primary
                      : AppColors.WHITE),
              _menuButton(SvgAssets.question,
                  onPress: _openFaq,
                  color: this.bgColor == AppColors.WHITE
                      ? AppColors.primary
                      : AppColors.WHITE),
            ],
          ),
        ),
      ),
    );
  }

  Widget _menuButton(String image, {Function() onPress, Color color}) {
    return CupertinoButton(
        padding: const EdgeInsets.only(top: 5),
        child: SvgPicture.asset(
          image,
          color: color,
          width: btnSize,
          height: btnSize,
        ),
        onPressed: onPress);
  }

  _openMorning() {
    appAnalitics.logEvent('first_morning');
    Get.to(MainMenuPage());
  }

  _openNight() {
    appAnalitics.logEvent('first_night');
    Get.to(MainMenuNightPage());
  }

  _openFaq() {
    appAnalitics.logEvent('first_faq');
    Get.to(FaqMenuPage());
  }

  _openProgress() {
    appAnalitics.logEvent('first_menu_progress');
    Get.to(ProgressPage());
  }
}
