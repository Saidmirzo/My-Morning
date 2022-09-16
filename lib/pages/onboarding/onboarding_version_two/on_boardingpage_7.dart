import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/pages/onboarding/components/line_window_two.dart';
import 'package:morningmagic/pages/onboarding/components/progress_bar.dart';
import '../../../resources/svg_assets.dart';
import '../../../routing/app_routing.dart';
import 'on_boardingpage_8.dart';

class OnBordingpageSevn extends StatefulWidget {
  const OnBordingpageSevn({Key key}) : super(key: key);

  @override
  State<OnBordingpageSevn> createState() => _OnBordingpageSevnState();
}

class _OnBordingpageSevnState extends State<OnBordingpageSevn> {
  void initState() {
    super.initState();
    AppMetrica.reportEvent('onbording_7');
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
              page: 7,
            ),
            const Spacer(
              flex: 2,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: "Over the past year, what's been ".tr,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
                children: [
                  TextSpan(
                      text: 'your experience'.tr,
                      style: const TextStyle(
                        color: Color(0xff6B0496),
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      )),
                  TextSpan(
                    text: ' building better habits?'.tr,
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
                onTap: () => Navigator.of(context)
                    .push(createRoute(const OnBordingpageEat())),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.5),
                  child: LineWindowTwo(
                    imageLineWindow: MyImages.onboardingV2Page7Icon1,
                    lineWindowTextOne: 'I have been '.tr,
                    linewindowTextTwo: 'constantly improving my habits'.tr,
                    linewindowTextTree: '7one'.tr,
                  ),
                )),
            const SizedBox(
              height: 11,
            ),
            GestureDetector(
                onTap: () => Navigator.of(context)
                    .push(createRoute(const OnBordingpageEat())),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.5),
                  child: LineWindowTwo(
                    imageLineWindow: MyImages.onboardingV2Page7Icon2,
                    lineWindowTextOne: 'I have built '.tr,
                    linewindowTextTwo: 'some good habits'.tr,
                    linewindowTextTree: '7two'.tr,
                  ),
                )),
            const SizedBox(
              height: 11,
            ),
            GestureDetector(
                onTap: () => Navigator.of(context)
                    .push(createRoute(const OnBordingpageEat())),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.5),
                  child: LineWindowTwo(
                    imageLineWindow: MyImages.onboardingV2Page7Icon3,
                    lineWindowTextOne: 'I have tried t build good habits,'.tr,
                    linewindowTextTwo: 'but have not kept up with them'.tr,
                    linewindowTextTree: '7tree'.tr,
                  ),
                )),
            const SizedBox(
              height: 11,
            ),
            GestureDetector(
                onTap: () => Navigator.of(context)
                    .push(createRoute(const OnBordingpageEat())),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.5),
                  child: LineWindowTwo(
                    imageLineWindow: MyImages.onboardingV2Page7Icon4,
                    lineWindowTextOne: 'I have not tried '.tr,
                    linewindowTextTwo: 'to build new habits'.tr,
                    linewindowTextTree: '7four'.tr,
                  ),
                )),
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
