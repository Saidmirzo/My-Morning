import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart';
import 'package:morningmagic/pages/onboarding/onboarding_version_three/onboarding_page_2.dart';
import 'package:morningmagic/resources/svg_assets.dart';
import 'package:morningmagic/utils/navigation_animation.dart';
import 'package:get/get.dart';

import '../../../services/analitics/all.dart';

class OnboardingVersionThirdPageOne extends StatefulWidget {
  const OnboardingVersionThirdPageOne({Key key}) : super(key: key);

  @override
  State<OnboardingVersionThirdPageOne> createState() =>
      _OnboardingVersionThirdPageOneState();
}

class _OnboardingVersionThirdPageOneState
    extends State<OnboardingVersionThirdPageOne> {
  void initState() {
    super.initState();
    AppMetrica.reportEvent('onbording_1');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              MyImages.onboardingV3page1Bg,
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            const Spacer(),
            Text(
              'onb_3_1_title'.tr,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w700,
                fontFamily: 'Montserrat',
              ),
            ),
            const SizedBox(
              height: 45,
            ),
            Text(
              'onb_3_1_subtitle'.tr,
              style: const TextStyle(
                color: Color(0xff592F72),
                fontWeight: FontWeight.w600,
                fontFamily: 'Montserrat',
              ),
            ),
            const Spacer(
              flex: 7,
            ),
            GestureDetector(
              onTap: () {
                appAnalitics.logEvent('app_open');
                Navigator.of(context).push(
                  createRoute(
                    const OnboardingVersionThirdPageTwo(),
                  ),
                );
              },
              child: Container(
                width: double.maxFinite,
                margin:
                    const EdgeInsets.only(left: 14.3, right: 14.3, bottom: 39),
                padding: const EdgeInsets.symmetric(
                  vertical: 22.23,
                ),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xff6B0496),
                  borderRadius: BorderRadius.circular(19),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.53),
                      blurRadius: 50,
                      spreadRadius: 10,
                      offset: const Offset(5, 20),
                    ),
                  ],
                ),
                child: Text(
                  "nexting".tr,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
            ),
            const SizedBox(),
          ],
        ),
      ),
    );
  }
}
