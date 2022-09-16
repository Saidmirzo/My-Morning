import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/pages/onboarding/components/line_window.dart';
import 'package:morningmagic/pages/onboarding/components/progress_bar.dart';
import '../../../resources/svg_assets.dart';
import '../../../routing/app_routing.dart';
import 'on_boardingpage_10.dart';

class OnBordingpageNine extends StatefulWidget {
  const OnBordingpageNine({Key key}) : super(key: key);

  @override
  State<OnBordingpageNine> createState() => _OnBordingpageNineState();
}

class _OnBordingpageNineState extends State<OnBordingpageNine> {
  void initState() {
    super.initState();
    AppMetrica.reportEvent('onbording_9');
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
              page: 9,
            ),
            const Spacer(
              flex: 2,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'How often '.tr,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
                children: [
                  TextSpan(
                      text: 'do you focus'.tr,
                      style: const TextStyle(
                        color: Color(0xff6B0496),
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      )),
                  TextSpan(
                    text: 'on the past or futue?'.tr,
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
                    .push(createRoute(const OnBordingpageTen())),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.5),
                  child: LineWindow(
                    imageLineWindow: MyImages.onboardingV2Page9Icon1,
                    lineWindowTextOne: 'Never '.tr,
                    linewindowTextTwo: 'I live in the present'.tr,
                  ),
                )),
            const SizedBox(
              height: 13,
            ),
            GestureDetector(
                onTap: () => Navigator.of(context)
                    .push(createRoute(const OnBordingpageTen())),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.5),
                  child: LineWindow(
                    imageLineWindow: MyImages.onboardingV2Page9Icon2,
                    lineWindowTextOne: 'Some '.tr,
                    linewindowTextTwo: 'of the time1'.tr,
                  ),
                )),
            const SizedBox(
              height: 13,
            ),
            GestureDetector(
                onTap: () => Navigator.of(context)
                    .push(createRoute(const OnBordingpageTen())),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.5),
                  child: LineWindow(
                    imageLineWindow: MyImages.onboardingV2Page9Icon3,
                    lineWindowTextOne: 'Most '.tr,
                    linewindowTextTwo: 'of the time2'.tr,
                  ),
                )),
            const SizedBox(
              height: 13,
            ),
            GestureDetector(
                onTap: () => Navigator.of(context)
                    .push(createRoute(const OnBordingpageTen())),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.5),
                  child: LineWindow(
                    imageLineWindow: MyImages.onboardingV2Page9Icon4,
                    lineWindowTextOne: 'All '.tr,
                    linewindowTextTwo: 'of the time3'.tr,
                  ),
                )),
            const Spacer(
              flex: 2,
            ),
            // const SkipToWelcomeButton(),
          ],
        ),
      ),
    );
  }
}
