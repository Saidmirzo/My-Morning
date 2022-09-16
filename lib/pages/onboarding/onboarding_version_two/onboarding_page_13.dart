import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/pages/onboarding/components/continue_button.dart';
import 'package:morningmagic/resources/svg_assets.dart';
import '../../../routing/app_routing.dart';
import 'onboarding_page_14.dart';

class OnboardingVersionSecondPage13 extends StatefulWidget {
  const OnboardingVersionSecondPage13({Key key}) : super(key: key);

  @override
  State<OnboardingVersionSecondPage13> createState() =>
      _OnboardingVersionSecondPage13State();
}

class _OnboardingVersionSecondPage13State
    extends State<OnboardingVersionSecondPage13> {
  void initState() {
    super.initState();
    AppMetrica.reportEvent('onbording_13');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(MyImages.onboardingV2page13Bg),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            const Spacer(),
            const Text(
              "MY MORNING",
              style: TextStyle(
                color: Colors.white,
                fontSize: 38,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
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
                  color: const Color(0xff6B0496).withOpacity(0.82),
                  borderRadius: BorderRadius.circular(19)),
              child: FittedBox(
                child: Text(
                  "your entire morning routine in one app".tr,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
            ),
            const Spacer(
              flex: 4,
            ),
            ContinueButton(
              callback: () {
                Navigator.of(context)
                    .push(createRoute(const OnboardingVersionSecondPage14()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
