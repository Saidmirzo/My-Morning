import 'dart:math';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
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
import 'package:morningmagic/resources/svg_assets.dart';
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
                    color: AppColors.nightModeBG,
                    border: Border.all(width: 0, color: AppColors.nightModeBG)),
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
                        onPressed: () => Get.off(
                            MeditationPage(fromHomeMenu: true),
                            opaque: true),
                        image: 'assets/images/home_menu/night_meditation.png',
                        title: 'music_menu_meditations'.tr,
                        subTitle: 'meditation_subtitle'.tr),
                    const SizedBox(height: 20),
                    _buildSettingsButton(
                        onPressed: () => Navigator.pushNamed(
                            context, musicInstrumentsPageRoute),
                        forSleep: true,
                        title: 'music_for_sleep_title'.tr,
                        subTitle: 'music_for_sleep_subtitle'.tr),
                    const SizedBox(height: 20),
                    _buildSettingsButton(
                        onPressed: () => Get.to(ReadingPage(
                              fromHomeMenu: true,
                            )),
                        image: 'assets/images/home_menu/book.png',
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
              bgColor: AppColors.nightModeBG,
            )),
      ]),
    );
  }

  Widget textTitleButton(String text) {
    return Text(text,
        style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 18,
            fontWeight: FontWeight.w600));
  }

  Widget textSubTitleButton(String text) {
    return Text(text,
        style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 13,
            fontWeight: FontWeight.w400));
  }

  Widget buildHeader() {
    return Container(
      decoration: BoxDecoration(gradient: AppColors.gradient_loading_night_bg),
      child: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Image.asset(
              '$imagePath/night_mode.png',
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
                      color: AppColors.nightModeBG,
                    ),
                  ),
                  Text(
                    'MY NIGHT',
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

  Widget _buildSettingsButton(
      {String title,
      String subTitle,
      String image,
      bool forSleep = false,
      Function() onPressed}) {
    return container(
      height: Get.width * .33,
      child: Stack(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Transform.rotate(
                angle: Random().nextInt(50) * Random().nextDouble() * 3.14,
                child: Image.asset('assets/images/home_menu/night_bg_btn.png',
                    width: Get.width, fit: BoxFit.fill),
              )),
          Positioned(
            right: 0,
            top: Random().nextInt(80) * 1.0,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  '$imagePath/cloud.png',
                )),
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            color: const Color(0xFFBEBFE7),
                            fontSize: 18,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        subTitle,
                        style: TextStyle(
                            color: const Color(0xFFBEBFE7),
                            fontSize: 13,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: ClipRRect(
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(12)),
                    child: forSleep == false
                        ? Image.asset(image,
                            width: Get.width, fit: BoxFit.contain)
                        : Stack(
                            children: [
                              Image.asset('assets/images/home_menu/notes.png',
                                  width: Get.width, fit: BoxFit.fitHeight),
                              Image.asset('assets/images/home_menu/piano.png',
                                  width: Get.width, fit: BoxFit.fitHeight)
                            ],
                          ) /* SvgPicture.asset(
                      image,
                      fit: fit,
                    ) */
                    ),
              ),
            ],
          ),
        ],
      ),
      color: AppColors.nightBtnBg,
      onPressed: onPressed,
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
