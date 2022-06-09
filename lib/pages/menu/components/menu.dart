import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:morningmagic/pages/menu/main_menu.dart';
import 'package:morningmagic/pages/nigth/nigth.dart';
import 'package:morningmagic/pages/progress/progress_page.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/resources/svg_assets.dart';
import 'package:morningmagic/routing/app_routing.dart';
import 'package:morningmagic/services/analitics/all.dart';
import 'package:morningmagic/storage.dart';

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
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: menuState == MenuState.MORNING ? Colors.black.withOpacity(.05) : Colors.white.withOpacity(.09),
            spreadRadius: 5,
            blurRadius: 10,
          ),
        ], borderRadius: BorderRadius.vertical(top: Radius.circular(30)), color: this.bgColor),
        child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _menuButton(SvgAssets.mountains, onPress: _openMorning, color: this.bgColor == AppColors.WHITE ? AppColors.primary : AppColors.nightButtonMenuIocons),
              _menuButton(SvgAssets.night, onPress: _openNight, color: this.bgColor == AppColors.WHITE ? AppColors.primary : AppColors.nightButtonMenuIocons),
              _menuButton(SvgAssets.progress, onPress: _openProgress, color: this.bgColor == AppColors.WHITE ? AppColors.primary : AppColors.nightButtonMenuIocons),
              _menuButton(SvgAssets.question, onPress: _openFaq, color: this.bgColor == AppColors.WHITE ? AppColors.primary : AppColors.nightButtonMenuIocons),
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
    AppRouting.navigateToHomeWithClearHistory(menuStateValue: MenuState.MORNING);
  }

  _openNight() {
    appAnalitics.logEvent('first_night');
    AppRouting.navigateToHomeWithClearHistory(menuStateValue: MenuState.NIGT);
  }

  _openFaq() {
    appAnalitics.logEvent('first_faq');
    Get.to(FaqMenuPage());
  }

  _openProgress() {
    AppMetrica.reportEvent('statistics_screen');
    appAnalitics.logEvent('first_menu_progress');
    Get.to(ProgressPage());
  }
}
