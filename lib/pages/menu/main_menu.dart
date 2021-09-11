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
import 'components/menu.dart';

class MainMenuPage extends StatefulWidget {
  @override
  State createState() {
    menuState = MenuState.MORNING;
    return MainMenuPageState();
  }
}

class MainMenuPageState extends State<MainMenuPage> {
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

    _clearExercisesHolder();
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
                color: Colors.white,
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Image.asset('$imagePath/logo.png', width: Get.width * .2),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(child: buildStartComplexButton(), flex: 1),
                        const SizedBox(width: 5),
                        Container(
                          width: Get.width * .49,
                          height: Get.width * .5,
                          child: Column(
                            children: [
                              buildMeditationsButton(),
                              Spacer(),
                              buildAffirmationsButton(),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    buildSettingsButton(),
                    const SizedBox(height: 30),
                    buildExercises()
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(bottom: 0, child: BottomMenu()),
      ]),
    );
  }

  Widget buildHeader() {
    return Container(
      color: Color(0xffFFB5C3),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'MY MORNING',
                    style: TextStyle(
                        fontSize: Get.width * .06,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  ClipPath(
                    clipper: OvalTopBorderClipper(),
                    child: Container(
                      height: 40,
                      color: Color(0xffffffff),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMeditationsButton() {
    return container(
      height: Get.width * .23,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Stack(
        children: [
          Positioned(
              right: 0,
              child: Image.asset(
                '$imagePath/meditation.png',
                height: Get.width * .23,
              )),
          Positioned.fill(
            left: 10,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'meditation_small'.tr,
                style: TextStyle(
                    fontSize: Get.width * .037,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
      color: Color(0xffFFD2DB),
      onPressed: () =>
          Get.off(MeditationPage(fromHomeMenu: true), opaque: true),
    );
  }

  Widget buildAffirmationsButton() {
    return container(
      height: Get.width * .23,
      child: Stack(
        children: [
          Positioned.fill(
            left: 10,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'affirmation_small'.tr,
                style: TextStyle(
                    fontSize: Get.width * .037,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Positioned(
              right: 0,
              child: Image.asset(
                '$imagePath/affirmation.png',
                height: Get.width * .23,
              )),
        ],
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      color: Color(0xffFFE6C0),
      onPressed: () =>
          Get.off(AffirmationPage(fromHomeMenu: true), opaque: true),
    );
  }

  Widget buildExercises() {
    return Column(
      children: [
        if (billingService.isPro())
          Row(
            children: [
              const SizedBox(width: 5),
              SvgPicture.asset('$imagePath/crown.svg'),
              const SizedBox(width: 10),
              Text(
                'subscription'.tr,
                style: TextStyle(
                    fontSize: Get.width * .045, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        const SizedBox(height: 10),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                exerciseBLock(
                  'assets/images/purchase/fitness.png',
                  'fitness_small'.tr,
                  'fitness_desc'.tr,
                  onPressed: () => openIfVip(FitnessMainPage(
                      pageId: TimerPageId.Fitness, fromHomeMenu: true)),
                ),
                exerciseBLock(
                  'assets/images/purchase/note.png',
                  'menu_diary_small'.tr,
                  'menu_diary_desc'.tr,
                  color: Color(0xffFFD2DB),
                  onPressed: () => openIfVip(DiaryPage(fromHomeMenu: true)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                exerciseBLock(
                  'assets/images/purchase/eye.png',
                  'visualization_small'.tr,
                  'visualization_desc'.tr,
                  color: Color(0xffE4C8FC),
                  onPressed: () =>
                      openIfVip(VisualizationMainPage(fromHomeMenu: true)),
                ),
                exerciseBLock(
                  'assets/images/purchase/book.png',
                  'reading_small'.tr,
                  'reading_desc'.tr,
                  onPressed: () => openIfVip(ReadingPage(fromHomeMenu: true)),
                ),
              ],
            ),
            const SizedBox(height: 120),
          ],
        )
      ],
    );
  }

  void openIfVip(Widget page) {
    billingService.isPro()
        ? Get.off(page, opaque: true)
        : Get.to(PaymentPage());
  }

  Widget exerciseBLock(String image, String title, String subtitle,
      {Color color, Function onPressed}) {
    return container(
      width: Get.width * .44,
      height: Get.width * .5,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.all(5),
      onPressed: onPressed,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 45,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(image, width: Get.width * .1),
                    Obx(() => !billingService.isVip.value
                        ? SvgPicture.asset('$imagePath/crown.svg')
                        : SizedBox())
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: Get.width * .047,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 5),
              Flexible(
                child: Text(
                  subtitle,
                  style: TextStyle(
                      color: AppColors.primary,
                      fontSize: Get.width * .035,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
        ],
      ),
      radius: 28,
      color: color ?? Color(0xffFFE6C0),
    );
  }

  Widget buildStartComplexButton() {
    return container(
      height: Get.width * .5,
      child: Stack(
        children: [
          Positioned(
            right: 0,
            child: Image.asset(
              '$imagePath/start_full.png',
              width: Get.width * .28,
            ),
          ),
          Positioned(
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  SizedBox(
                    width: Get.width * .4,
                    child: Text(
                      'start_complex'.tr,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Get.width * .047,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 13),
                  Container(
                    alignment: Alignment.bottomRight,
                    width: Get.width * .35,
                    child: Container(
                      height: Get.width * .09,
                      width: Get.width * .3,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('start'.tr,
                              style: TextStyle(color: Colors.black)),
                          Icon(Icons.arrow_forward, color: Colors.black),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      color: Color(0xff592F72),
      onPressed: _startExercise,
    );
  }

  Widget buildSettingsButton() {
    return container(
      height: Get.width * .23,
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
                  'settings'.tr,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: Get.width * .06,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 6),
                Text(
                  'settings_desc'.tr,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: Get.width * .04,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ],
      ),
      color: Color(0xff592F72),
      onPressed: _openSettings,
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

  _clearExercisesHolder() async {
    await MyDB()
        .getBox()
        .put(MyResource.EXERCISES_HOLDER, ExerciseHolder([], []));
  }

  _startExercise() async {
    var _cntBeforInterview = launchForinterview + 1;
    await MyDB()
        .getBox()
        .put(MyResource.LAUNCH_FOR_INTERVIEW, _cntBeforInterview);
    openInterviewModel(_cntBeforInterview);
    appAnalitics.logEvent('first_start');
    await OrderUtil()
        .getRouteByPositionInList(await OrderUtil().getNextPos(0))
        .then((value) {
      Get.off(value);
    });
  }

  void openInterviewModel(int _cntBeforInterview) async {
    bool isInterviewed = await MyDB()
        .getBox()
        .get(MyResource.IS_DONE_INTERVIEW, defaultValue: false);
    if (_cntBeforInterview > 2 && !isInterviewed)
      Future.delayed(Duration(seconds: 1),
          () => Get.dialog(InterviewDialog(), barrierDismissible: false));
  }

  _openSettings() {
    appAnalitics.logEvent('first_menu_setings');
    Navigator.pushNamed(context, settingsPageRoute);
  }
}
