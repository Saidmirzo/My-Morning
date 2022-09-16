import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/pages/onboarding/components/line_window_two.dart';
import 'package:morningmagic/pages/onboarding/components/progress_bar.dart';
import '../../../resources/svg_assets.dart';
import '../../../routing/app_routing.dart';
import 'onboarding_page_11.dart';

class OnBordingpageTen extends StatefulWidget {
  const OnBordingpageTen({Key key}) : super(key: key);

  @override
  State<OnBordingpageTen> createState() => _OnBordingpageTenState();
}

class _OnBordingpageTenState extends State<OnBordingpageTen> {
  void initState() {
    super.initState();
    AppMetrica.reportEvent('onbording_10');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // padding: const EdgeInsets.all(14.5),
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(MyImages.onboardingV2page2Bg),
              fit: BoxFit.fill),
        ),
        child: Column(
          children: [
            const Spacer(),
            const ProgressBar(
              page: 10,
            ),
            const Spacer(
              flex: 2,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: "How ".tr,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
                children: [
                  TextSpan(
                      text: 'distractable'.tr,
                      style: const TextStyle(
                        color: Color(0xff6B0496),
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      )),
                  TextSpan(
                    text: ' are you?'.tr,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () => Navigator.of(context).push(
                  createRoute(const OnboardingVersionSecondPageElevent())),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.5),
                child: LineWindowTwo(
                  imageLineWindow: MyImages.onboardingV2Page10Icon1,
                  lineWindowTextOne: 'Easily '.tr,
                  linewindowTextTwo: 'distracted'.tr,
                ),
              ),
            ),
            const SizedBox(
              height: 13,
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).push(
                  createRoute(const OnboardingVersionSecondPageElevent())),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.5),
                child: LineWindowTwo(
                  imageLineWindow: MyImages.onboardingV2Page10Icon2,
                  lineWindowTextOne: 'Sometimes '.tr,
                  linewindowTextTwo: 'lose focus'.tr,
                ),
              ),
            ),
            const SizedBox(
              height: 13,
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).push(
                  createRoute(const OnboardingVersionSecondPageElevent())),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.5),
                child: LineWindowTwo(
                  imageLineWindow: MyImages.onboardingV2Page10Icon3,
                  lineWindowTextOne: 'Rarely '.tr,
                  linewindowTextTwo: 'lose focus'.tr,
                ),
              ),
            ),
            const SizedBox(
              height: 13,
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).push(
                  createRoute(const OnboardingVersionSecondPageElevent())),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.5),
                child: LineWindowTwo(
                  imageLineWindow: MyImages.onboardingV2Page10Icon4,
                  lineWindowTextOne: 'Laser '.tr,
                  linewindowTextTwo: ' focus'.tr,
                ),
              ),
            ),
            const Spacer(
              flex: 2,
            ),
            //const SkipToWelcomeButton(),
          ],
        ),
      ),
    );
  }
}
