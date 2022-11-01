import 'dart:async';

import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:appodeal_flutter/appodeal_flutter.dart' as appo;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/dialog/connection_dialog.dart';
import 'package:morningmagic/features/fitness/presentation/pages/fitness_main_page.dart';
import 'package:morningmagic/features/visualization/presentation/pages/visualization_main_page.dart';
import 'package:morningmagic/pages/affirmation/affirmation_page.dart';
import 'package:morningmagic/pages/diary/diary_page.dart';
import 'package:morningmagic/pages/faq/faq_menu.dart';
import 'package:morningmagic/pages/meditation/meditation_page.dart';
import 'package:morningmagic/pages/reading/reading_page.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/routing/route_values.dart';
import 'package:morningmagic/routing/timer_page_ids.dart';
import 'package:morningmagic/services/analitics/all.dart';
import 'package:morningmagic/services/analitics/analyticService.dart';
import 'package:morningmagic/services/connection_service/connection_service.dart';
import 'package:morningmagic/storage.dart';
import 'package:morningmagic/utils/oval_top_clipper.dart';
import 'package:morningmagic/utils/reordering_util.dart';
import 'package:provider/provider.dart';
import '../../db/model/exercise/exercise_holder.dart';
import '../../db/resource.dart';
import '../../dialog/interviewDialog.dart';
import '../../services/ab_testing_service.dart';
import '../paywall/paywall_provider.dart';
import 'components/menu.dart';
import 'components/questions_dialog.dart';

bool isComplex = false;

class MainMenuPage extends StatefulWidget {
  const MainMenuPage({Key key}) : super(key: key);

  @override
  State createState() {
    return MainMenuPageState();
  }
}

class MainMenuPageState extends State<MainMenuPage> {
  int launchForinterview = 0;
  final String imagePath = 'assets/images/home_menu';

  @override
  void initState() {
    super.initState();
    // admobService.createInterstitialAd();

    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    //   if (GetPlatform.isIOS) {
    //     // Show tracking authorization dialog and ask for permission
    //     AppTrackingTransparency.requestTrackingAuthorization();
    //   }
    // });

    Future.delayed(
      const Duration(seconds: 4),
      () async {
        if (!(await ConnectionRepo.isConnected())) {
          showDialog(
            context: context,
            builder: (context) {
              return const ConnectionDialog();
            },
          );
        }
      },
    );

    _clearExercisesHolder();
    AnalyticService.screenView('menu_page');
  }

  @override
  Widget build(BuildContext context) {
    launchForinterview = MyDB().getBox().get(MyResource.LAUNCH_FOR_INTERVIEW, defaultValue: 0);
    return Scaffold(
      body: GestureDetector(
        onTap: (context.watch<PayWallProvider>().isShowAds)
            ? () async {
                await appo.Appodeal.show(appo.AdType.interstitial,
                    placementName: "main_menu");
                context.read<PayWallProvider>().startTimer();
              }
            : null,
        child: Stack(
          children: [
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
                        const SizedBox(
                          height: 10.69,
                        ),
                        const Text(
                          'MY MORNING',
                          style: TextStyle(
                              color: Color(0xffD1ADE7),
                              fontFamily: 'Montserrat',
                              fontStyle: FontStyle.normal,
                              fontSize: 19.47,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 25.04),
                        buildStartComplexButton(),
                        const SizedBox(
                          height: 12.6,
                        ),
                        SizedBox(
                          width: Get.width - 10,
                          child: Row(
                            children: [
                              buildMeditationsButton(),
                              const Spacer(),
                              buildAffirmationsButton(),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        buildExercises()
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Positioned(
              bottom: 0,
              child: BottomMenu(
                currentPageNumber: 1,
              ),
            ),
            // if (context.watch<PayWallProvider>().isShowAds)
            //   GestureDetector(
            //     onTap: () async {
            //       await appo.Appodeal.show(appo.AdType.interstitial, placementName: "main_menu");
            //       context.read<PayWallProvider>().startTimer();
            //     },
            //     child: Positioned.fill(
            //         child: Container(
            //       color: Colors.transparent,
            //     )),
            //   )
          ],
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Container(
      color: const Color(0xffFFB5C3),
      child: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Image.asset(
              '$imagePath/header.png',
            ),
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(height: 20),
                  ClipPath(
                    clipper: OvalTopBorderClipper(),
                    child: Container(
                      height: 40,
                      color: const Color(0xffffffff),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 24,
              right: 24,
              child: newQuestionsButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget newQuestionsButton() {
    return GestureDetector(
      onTap: () {
        appAnalitics.logEvent('first_faq');
        Get.to(() => const FaqMenuPage());
      },
      child: Container(
        width: 47.05,
        height: 47.05,
        padding: const EdgeInsets.all(12.76),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Image.asset(
          '$imagePath/settings_icon_2.png',
        ),
      ),
    );
  }

  Widget buildMeditationsButton() {
    return GestureDetector(
      onTap: () {
        AppMetrica.reportEvent('meditation_start');
        Get.off(() => const MeditationPage(fromHomeMenu: true), opaque: true);
        isComplex = false;
      },
      child: Container(
        width: (Get.width - 30) / 2,
        height: Get.width * .23,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(19),
          image: const DecorationImage(
            image: AssetImage("assets/images/Meditationimg.jpeg"),
            fit: BoxFit.fill,
          ),
          color: const Color(0xffFFD2DB),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 31, 10, 30),
          child: Text(
            'meditation_small'.tr,
            style: TextStyle(fontSize: Get.width * .037, color: AppColors.primary, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }

  Widget buildAffirmationsButton() {
    return GestureDetector(
      onTap: () {
        AppMetrica.reportEvent('affirmations_start');
        Get.off(() => const AffirmationPage(fromHomeMenu: true), opaque: true);
        isComplex = false;
      },
      child: Container(
        width: (Get.width - 30) / 2,
        height: Get.width * .23,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(19),
          image: const DecorationImage(
            image: AssetImage("assets/images/afirmationimg.jpeg"),
            fit: BoxFit.fill,
          ),
          color: const Color(0xffFFD2DB),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 10, right: 10),
          child: Row(
            children: [
              const SizedBox(
                height: 24,
              ),
              Text(
                'affirmation_smal'.tr,
                style: TextStyle(fontSize: Get.width * .037, color: AppColors.primary, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildExercises() {
    return Column(
      children: [
        // if (!billingService.isPro())
        Row(
          children: [
            const SizedBox(width: 5),
            GestureDetector(child: SvgPicture.asset('$imagePath/crown.svg')),
            const SizedBox(width: 10),
            Container(
              width: MediaQuery.of(context).size.width - 57,
              child: AutoSizeText(
                billingService.isPro()
                    ? 'PREMIUM activated'.tr
                    : 'Try PREMIUM Package for free'.tr,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                minFontSize: 14,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff592F72)),
                textAlign: TextAlign.left,
              ),
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
                  onPressed: () {
                    isComplex = false;
                    AppMetrica.reportEvent('fitness_start');
                    openIfVip(const FitnessMainPage(
                      pageId: TimerPageId.Fitness,
                      fromHomeMenu: true,
                    ));
                  },
                ),
                exerciseBLock(
                  'assets/images/purchase/note.png',
                  'menu_diary_small'.tr,
                  'menu_diary_desc'.tr,
                  color: const Color(0xffFFD2DB),
                  onPressed: () {
                    isComplex = false;
                    AppMetrica.reportEvent('diary_start');
                    openIfVip(const DiaryPage(fromHomeMenu: true));
                  },
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
                  color: const Color(0xffE4C8FC),
                  onPressed: () async {
                    isComplex = false;
                    if (await ConnectionRepo.isConnected()) {
                      AppMetrica.reportEvent('visualization_start');
                      openIfVip(
                        const VisualizationMainPage(fromHomeMenu: true),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return const ConnectionDialog();
                        },
                      );
                    }
                  },
                ),
                exerciseBLock(
                  'assets/images/purchase/book.png',
                  'reading_small'.tr,
                  'reading_desc'.tr,
                  onPressed: () {
                    isComplex = false;
                    AppMetrica.reportEvent('reading_start');
                    openIfVip(const ReadingPage(fromHomeMenu: true));
                  },
                ),
              ],
            ),
            const SizedBox(height: 120),
          ],
        )
      ],
    );
  }

  void openIfVip(Widget page) async {
    if (billingService.isPro()) {
      Get.off(() => page, opaque: true);
    } else {
      await Get.to(() => ABTestingService.getPaywall());
      setState(() {});
    }
  }

  Widget exerciseBLock(String image, String title, String subtitle, {Color color, Function onPressed}) {
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
              SizedBox(
                height: 45,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(image, width: Get.width * .1),
                    Obx(() => !billingService.isVip.value ? SvgPicture.asset('$imagePath/crown.svg') : const SizedBox())
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
                  style: TextStyle(color: AppColors.primary, fontSize: Get.width * .035, fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
        ],
      ),
      radius: 28,
      color: color ?? const Color(0xffFFE6C0),
    );
  }

  Widget buildStartComplexButton() {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('$imagePath/start_full2.png'),
            fit: BoxFit.fill,
          ),
          borderRadius: BorderRadius.circular(19)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: questionButtonForComplexButton(),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            'start_complex'.tr,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              fontFamily: 'Montserrat',
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: [
              buildStartButton(),
              const SizedBox(
                width: 7,
              ),
              buildSettingsButton(),
            ],
          ),
        ],
      ),
    );
  }

  Widget questionButtonForComplexButton() {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return const QuestionsDialog();
          },
        );
      },
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(image: AssetImage('$imagePath/questions_img.png'), fit: BoxFit.fill),
        ),
      ),
    );
  }

  Widget buildStartButton() {
    return Expanded(
      child: GestureDetector(
        onTap: _startExercise,
        child: Container(
          height: 51.75,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            'start'.tr,
            style: const TextStyle(
              color: Color(0xff592F72),
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: 'Montserrat',
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSettingsButton() {
    return GestureDetector(
      onTap: _openSettings,
      child: Container(
        width: 51.75,
        height: 51.75,
        padding: const EdgeInsets.all(15.11),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Image.asset(
          '$imagePath/settings_icon_1.png',
        ),
      ),
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
    isComplex = true;
    AppMetrica.reportEvent('complex_start');
    var _cntBeforInterview = launchForinterview + 1;
    await MyDB().getBox().put(MyResource.LAUNCH_FOR_INTERVIEW, _cntBeforInterview);
    appAnalitics.logEvent('first_start');
    Get.to(const MeditationPage());
    await OrderUtil().getRouteByPositionInList(await OrderUtil().getNextPos(0)).then((value) {
      Get.off(() => value);
    });
  }

  void openInterviewModel(int _cntBeforInterview) async {
    bool isInterviewed = await MyDB().getBox().get(MyResource.IS_DONE_INTERVIEW, defaultValue: false);
    if (_cntBeforInterview > 2 && !isInterviewed)
      Future.delayed(const Duration(seconds: 1), () => Get.dialog(const InterviewDialog(), barrierDismissible: false));
  }

  _openSettings() {
    appAnalitics.logEvent('first_menu_setings');
    Navigator.pushNamed(context, settingsPageRoute);
  }
}
