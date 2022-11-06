import 'dart:async';
import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/components/custom_gradient_circular.dart';
import 'package:morningmagic/pages/onboarding/onboarding_version_two/onboarding_page_12.dart';
import 'package:morningmagic/resources/svg_assets.dart';
import 'package:morningmagic/routing/app_routing.dart';

class OnboardingVersionSecondPageElevent extends StatefulWidget {
  const OnboardingVersionSecondPageElevent({Key key}) : super(key: key);

  @override
  State<OnboardingVersionSecondPageElevent> createState() => _OnboardingVersionSecondPageEleventState();
}

class _OnboardingVersionSecondPageEleventState extends State<OnboardingVersionSecondPageElevent> {
  Timer timer;
  double circularValue = 0.0;
  int textValue = 0;
  @override
  void initState() {
    timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (circularValue >= 1) {
        timer.cancel();
        Get.to(createRoute(const OnboardingVersionSecondPageTwelve()));
      } else {
        setState(() {
          circularValue += 1 / 100;
          textValue += 1;
        });
      }
    });
    super.initState();
    AppMetrica.reportEvent('onbording_11');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(MyImages.onbording11page),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const Spacer(),
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.symmetric(
                vertical: 24,
                horizontal: 34,
              ),
              margin: const EdgeInsets.symmetric(
                horizontal: 27.43,
              ),
              decoration: BoxDecoration(
                  color: const Color(0xff6B0496).withOpacity(0.82), borderRadius: BorderRadius.circular(19)),
              child: FittedBox(
                child: Text(
                  "We’re finalizing your personalized journey...".tr,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 21.23,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20.8,
            ),
            CircularContainer(
              circularValue: circularValue,
              text: textValue.toString(),
            ),
            const Spacer(
              flex: 4,
            ),
            // const SkipToWelcomeButton(),
          ],
        ),
      ),
    );
  }
}
