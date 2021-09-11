import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/dialog/interviewDialog.dart';
import 'package:morningmagic/features/fitness/presentation/pages/fitness_main_page.dart';
import 'package:morningmagic/features/visualization/presentation/pages/visualization_main_page.dart';
import 'package:morningmagic/pages/affirmation/affirmation_page.dart';
import 'package:morningmagic/pages/diary/diary_page.dart';
import 'package:morningmagic/pages/meditation/meditation_page.dart';
import 'package:morningmagic/pages/menu/components/menu.dart';
import 'package:morningmagic/pages/payment.dart';
import 'package:morningmagic/pages/reading/reading_page.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/routing/route_values.dart';
import 'package:morningmagic/routing/timer_page_ids.dart';
import 'package:morningmagic/services/admob.dart';
import 'package:morningmagic/services/analitics/all.dart';
import 'package:morningmagic/services/analitics/analyticService.dart';
import 'package:morningmagic/storage.dart';
import 'package:morningmagic/utils/oval_top_clipper.dart';
import 'package:morningmagic/utils/reordering_util.dart';

import '../../db/hive.dart';
import '../../db/model/exercise/exercise_holder.dart';
import '../../db/resource.dart';

class MainMenuNightPage extends StatefulWidget {
  @override
  State createState() {
    menuState = MenuState.NIGT;
    return MainMenuNightPageState();
  }
}

class MainMenuNightPageState extends State<MainMenuNightPage> {
  int launchForinterview = 0;
  final String imagePath = 'assets/images/home_menu';

  @override
  void initState() {
    super.initState();
    admobService.createInterstitialAd();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (GetPlatform.isIOS) {
        // Show tracking authorization dialog and ask for permission
        AppTrackingTransparency.requestTrackingAuthorization();
      }
    });

    AnalyticService.screenView('menu_page');
  }

  @override
  Widget build(BuildContext context) {
    launchForinterview =
        MyDB().getBox().get(MyResource.LAUNCH_FOR_INTERVIEW, defaultValue: 0);
    return Scaffold(
      body: Stack(children: [
        SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: [
              buildHeader(),
              Container(
                height: Get.height,
                decoration: BoxDecoration(
                    color: AppColors.primary,
                    border: Border.all(width: 0, color: AppColors.primary)),
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'welcome_to_sleep'.tr,
                      style: TextStyle(
                          fontSize: Get.width * .06,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 30),
                    _buildSettingsButton(
                        title: 'music_menu_meditations'.tr,
                        subTitle: 'meditation_subtitle'.tr),
                    const SizedBox(height: 20),
                    _buildSettingsButton(
                        title: 'music_for_sleep_title'.tr,
                        subTitle: 'music_for_sleep_subtitle'.tr),
                    const SizedBox(height: 20),
                    _buildSettingsButton(
                        title: 'reading_at_night_title'.tr,
                        subTitle: 'reading_at_night_subtitle'.tr),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
            bottom: 0,
            child: BottomMenu(
              bgColor: AppColors.VIOLET,
            )),
      ]),
    );
  }

  Widget buildHeader() {
    return Container(
      decoration: BoxDecoration(gradient: AppColors.gradient_loading_night_bg),
      child: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Image.asset(
              '$imagePath/header.png',
            ),
            //SvgPicture.asset('$imagePath/header.svg'),
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                //mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ClipPath(
                    clipper: OvalTopBorderClipper(),
                    child: Container(
                      height: 40,
                      color: AppColors.primary,
                    ),
                  ),
                  Text(
                    'MY MORNING',
                    style: TextStyle(
                        fontSize: Get.width * .03,
                        fontWeight: FontWeight.normal,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsButton({String title, String subTitle}) {
    return container(
      height: Get.width * .33,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              '$imagePath/settings.png',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: Get.width * .05,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 6),
                Text(
                  subTitle,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: Get.width * .03,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ],
      ),
      color: Color(0xff592F72),
      onPressed: () => Navigator.pushNamed(context, settingsPageRoute),
    );
  }

  Widget container({
    double width,
    double height,
    double radius = 12,
    EdgeInsets margin,
    EdgeInsets padding,
    Widget child,
    Color color = Colors.orangeAccent,
    Function onPressed,
  }) {
    return CupertinoButton(
      onPressed: onPressed,
      padding: const EdgeInsets.all(0),
      child: Container(
        width: width,
        height: height,
        child: child,
        margin: margin,
        padding: padding,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: color,
        ),
      ),
    );
  }
}
