import 'dart:io';
import 'dart:ui';
import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:morningmagic/pages/onboarding/onboarding_version_one/onboarding_2_page.dart';
import 'package:morningmagic/resources/colors.dart';
import '../../../routing/app_routing.dart';
import '../../../services/analitics/all.dart';

class OnBoarding1Page extends StatefulWidget {
  const OnBoarding1Page({Key key}) : super(key: key);

  @override
  State<OnBoarding1Page> createState() => _OnBoarding1PageState();
}

class _OnBoarding1PageState extends State<OnBoarding1Page> {
  @override
  void initState() {
    super.initState();
    AppMetrica.reportEvent('onbording_1');
    print('ONBOARDING OnBoarding1Page');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset("assets/images/onboarding/onb_bg_1.svg",
              fit: BoxFit.cover),
          ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const Text(
                        "MY MORNING",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: 23),
                        textAlign: TextAlign.center,
                      ),
                      const Spacer(),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Text(
                              "onb_1_text_1".tr.split("@d").first,
                              style: TextStyle(
                                  fontSize: Platform.isIOS ? 22 : 19,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.violetOnb.withOpacity(0.5)),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "onb_1_text_1".tr.split("@d").last,
                              style: TextStyle(
                                  // calculateOpanApp();
                                  // if (myDbBox != null && myDbBox.get(MyResource.USER_KEY) != null) {
                                  //   return getMenuPage();
                                  // } else {
                                  //   AnalyticService.analytics.logAppOpen();
                                  //   return await getOnboardingFromFirebase();
                                  // }                   fontSize: Platform.isIOS ? 20 : 17,
                                  color: AppColors.violetOnb.withOpacity(0.5)),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      SvgPicture.asset(
                          "assets/images/onboarding/onb_image_1.svg"),
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.white,
                              spreadRadius: 6,
                              blurRadius: 60,
                              offset: Offset(0, 0),
                            )
                          ],
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: AppColors.violetOnb,
                            minimumSize: const Size(double.infinity, 64),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {
                            appAnalitics.logEvent('app_open');
                            Navigator.of(context)
                                .push(createRoute(const OnBoarding2Page()));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "onb_1_btn".tr,
                                style: TextStyle(
                                    fontSize: Platform.isIOS ? 15 : 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Icon(Icons.arrow_forward, size: 20),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
