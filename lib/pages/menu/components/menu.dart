import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:morningmagic/pages/progress/progress_page.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/resources/svg_assets.dart';
import 'package:morningmagic/routing/app_routing.dart';
import 'package:morningmagic/services/analitics/all.dart';
import 'package:morningmagic/storage.dart';
import '../../reminders/reminders_page.dart';

class BottomMenu extends StatelessWidget {
  final double btnSize = 30;
  final Color bgColor;
  final int currentPageNumber;

  const BottomMenu(
      {Key key,
      this.bgColor = AppColors.WHITE,
      @required this.currentPageNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      color: Colors.transparent,
      child: Container(
        width: Get.width,
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: menuState == MenuState.MORNING
                    ? Colors.black.withOpacity(.05)
                    : Colors.white.withOpacity(.09),
                spreadRadius: 5,
                blurRadius: 10,
              ),
            ],
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
            color: bgColor),
        child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _menuButton(
                SvgAssets.mountains,
                'Morning'.tr,
                onPress: _openMorning,
                color: bgColor == AppColors.WHITE
                    ? currentPageNumber == 1
                        ? AppColors.primary
                        : AppColors.primary.withOpacity(.34)
                    : currentPageNumber == 1
                        ? AppColors.nightButtonMenuIocons
                        : AppColors.nightButtonMenuIocons.withOpacity(.34),
              ),
              _menuButton(
                SvgAssets.night,
                'Evening'.tr,
                onPress: _openNight,
                color: bgColor == AppColors.WHITE
                    ? currentPageNumber == 2
                        ? AppColors.primary
                        : AppColors.primary.withOpacity(.34)
                    : currentPageNumber == 2
                        ? AppColors.nightButtonMenuIocons
                        : AppColors.nightButtonMenuIocons.withOpacity(.34),
              ),
              _menuButton(
                SvgAssets.progress,
                'Statistics'.tr,
                onPress: _openProgress,
                color: bgColor == AppColors.WHITE
                    ? currentPageNumber == 3
                        ? AppColors.primary
                        : AppColors.primary.withOpacity(.34)
                    : currentPageNumber == 3
                        ? AppColors.nightButtonMenuIocons
                        : AppColors.nightButtonMenuIocons.withOpacity(.34),
              ),
              _menuButton(
                'assets/images/home_menu/notification_icon.svg',
                'Notifications'.tr,
                onPress: _openFaq,
                color: bgColor == AppColors.WHITE
                    ? currentPageNumber == 4
                        ? AppColors.primary
                        : AppColors.primary.withOpacity(.34)
                    : currentPageNumber == 4
                        ? AppColors.nightButtonMenuIocons
                        : AppColors.nightButtonMenuIocons.withOpacity(.34),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _menuButton(
    String image,
    String text, {
    Function() onPress,
    Color color,
  }) {
    return CupertinoButton(
      padding: const EdgeInsets.only(top: 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            image,
            color: color,
            width: btnSize * 0.7,
            height: btnSize * 0.7,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: FontWeight.w700,
              fontFamily: 'Montserrat',
            ),
          ),
        ],
      ),
      onPressed: onPress,
    );
  }

  _openMorning() {
    appAnalitics.logEvent('first_morning');
    AppRouting.navigateToHomeWithClearHistory(
        menuStateValue: MenuState.MORNING);
  }

  _openNight() {
    appAnalitics.logEvent('first_night');
    AppRouting.navigateToHomeWithClearHistory(menuStateValue: MenuState.NIGT);
  }

  _openFaq() {
    // appAnalitics.logEvent('first_faq');
    Get.to(RemindersPage());
  }

  _openProgress() {
    AppMetrica.reportEvent('statistics_screen');
    appAnalitics.logEvent('first_menu_progress');
    Get.to(const ProgressPage());
  }
}
