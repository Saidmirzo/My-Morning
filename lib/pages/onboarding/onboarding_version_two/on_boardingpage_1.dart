import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/pages/onboarding/components/button_widget.dart';
import 'package:morningmagic/resources/svg_assets.dart';
import '../../../routing/app_routing.dart';
import '../../../services/analitics/all.dart';
import 'on_boardingpage_2.dart';

class OnboardingVersionSecondPage1 extends StatefulWidget {
  const OnboardingVersionSecondPage1({
    Key key,
  }) : super(key: key);

  @override
  State<OnboardingVersionSecondPage1> createState() =>
      _OnboardingVersionSecondPage1State();
}

class _OnboardingVersionSecondPage1State
    extends State<OnboardingVersionSecondPage1> {
  void initState() {
    super.initState();
    AppMetrica.reportEvent('onbording_1');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(MyImages.onboardingV2page1Bg),
              fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 75,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: '',
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                ),
                children: [
                  TextSpan(
                      text: 'Change your life with'.tr,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Montserrat',
                      )),
                  TextSpan(
                      text: 'morning rituals'.tr,
                      style: const TextStyle(
                        color: Color(0xff6B0496),
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Montserrat',
                      ))
                ],
              ),
            ),
            const Spacer(),
            ButtonWidget(
              callBack: () {
                appAnalitics.logEvent('app_open');
                Navigator.of(context)
                    .push(createRoute(const OnBordingpageTwo()));
              },
            ),
            const SizedBox(),
          ],
        ),
      ),
    );
  }
}
