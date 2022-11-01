import 'dart:math';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/pages/meditation/meditation_page.dart';
import 'package:morningmagic/pages/menu/components/menu.dart';
import 'package:morningmagic/pages/paywall/paywall_provider.dart';
import 'package:morningmagic/pages/reading/reading_page.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/routing/route_values.dart';
import 'package:morningmagic/services/analitics/analyticService.dart';
import 'package:morningmagic/utils/oval_top_clipper.dart';
import 'package:provider/provider.dart';
import 'package:stack_appodeal_flutter/stack_appodeal_flutter.dart';
import '../../db/resource.dart';

class MainMenuNightPage extends StatefulWidget {
  const MainMenuNightPage({Key key}) : super(key: key);

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
    // admobService.createInterstitialAd();
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
    launchForinterview = MyDB().getBox().get(MyResource.LAUNCH_FOR_INTERVIEW, defaultValue: 0);
    return Scaffold(
      body: Stack(children: [
        ListView(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          children: [
            buildHeader(),
            Container(
              decoration: BoxDecoration(
                  color: AppColors.nightModeBG, border: Border.all(width: 0, color: AppColors.nightModeBG)),
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'welcome_to_sleep'.tr,
                    style: TextStyle(fontSize: Get.width * .06, fontWeight: FontWeight.w700, color: Colors.white),
                  ),
                  const SizedBox(height: 30),
                  _buildSettingsButton(
                      onPressed: () {
                        AppMetrica.reportEvent('night_meditation_start');
                        Get.off(const MeditationPage(fromHomeMenu: true), opaque: true);
                      },
                      image: 'assets/images/home_menu/night_meditation.png',
                      title: 'music_menu_meditations'.tr,
                      subTitle: 'meditation_subtitle'.tr),
                  const SizedBox(height: 20),
                  _buildSettingsButton(
                      onPressed: () {
                        AppMetrica.reportEvent('night_sounds_start');
                        Navigator.pushNamed(context, musicInstrumentsPageRoute);
                      },
                      forSleep: true,
                      title: 'music_for_sleep_title'.tr,
                      subTitle: 'music_for_sleep_subtitle'.tr),
                  const SizedBox(height: 20),
                  _buildSettingsButton(
                      onPressed: () {
                        AppMetrica.reportEvent('night_reading_start');
                        Get.to(() => const ReadingPage(
                              fromHomeMenu: true,
                            ));
                      },
                      image: 'assets/images/home_menu/book.png',
                      title: 'reading_at_night_title'.tr,
                      subTitle: 'reading_at_night_subtitle'.tr),
                  const SizedBox(
                    height: 100,
                  )
                ],
              ),
            ),
          ],
        ),
        Consumer<PayWallProvider>(builder: (context, model, child) {
          return model.isShowAds
              ? GestureDetector(
                  onTap: () async {
                    await Appodeal.show(AppodealAdType.Interstitial, "main_menu");
                    context.read<PayWallProvider>().startTimer();
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.transparent,
                  ),
                )
              : const SizedBox.shrink();
        }),
        const Positioned(
          bottom: 0,
          child: BottomMenu(
            bgColor: AppColors.nightModeBG,
            currentPageNumber: 2,
          ),
        ),
      ]),
    );
  }

  Widget textTitleButton(String text) {
    return Text(text, style: const TextStyle(fontFamily: 'Montserrat', fontSize: 18, fontWeight: FontWeight.w600));
  }

  Widget textSubTitleButton(String text) {
    return Text(text, style: const TextStyle(fontFamily: 'Montserrat', fontSize: 13, fontWeight: FontWeight.w400));
  }

  Widget buildHeader() {
    return Container(
      decoration: const BoxDecoration(gradient: AppColors.gradient_loading_night_bg),
      child: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Image.asset(
              '$imagePath/night_mode.png',
            ),
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
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
                    style: TextStyle(fontSize: Get.width * .03, fontWeight: FontWeight.normal, color: Colors.white),
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
      {String title, String subTitle, String image, bool forSleep = false, Function() onPressed}) {
    return container(
      height: Get.width * .33,
      child: Stack(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Transform.rotate(
                angle: Random().nextInt(50) * Random().nextDouble() * 3.14,
                child: Image.asset('assets/images/home_menu/night_bg_btn.png', width: Get.width, fit: BoxFit.fill),
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
                        style: const TextStyle(
                            color: Color(0xFFBEBFE7),
                            fontSize: 18,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        subTitle,
                        style: const TextStyle(
                            color: Color(0xFFBEBFE7),
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
                    borderRadius: const BorderRadius.only(bottomRight: Radius.circular(12)),
                    child: forSleep == false
                        ? Image.asset(image, width: Get.width, fit: BoxFit.contain)
                        : Stack(
                            children: [
                              Image.asset('assets/images/home_menu/notes.png', width: Get.width, fit: BoxFit.fitHeight),
                              Image.asset('assets/images/home_menu/piano.png', width: Get.width, fit: BoxFit.fitHeight)
                            ],
                          )),
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
