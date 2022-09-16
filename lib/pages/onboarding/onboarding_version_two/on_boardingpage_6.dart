import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/pages/onboarding/components/line_window_stacks.dart';
import 'package:morningmagic/pages/onboarding/components/progress_bar.dart';
import '../../../resources/svg_assets.dart';
import '../../../routing/app_routing.dart';
import 'on_boardingpage_7.dart';

class OnBordingpageSix extends StatefulWidget {
  const OnBordingpageSix({Key key}) : super(key: key);

  @override
  State<OnBordingpageSix> createState() => _OnBordingpageSixState();
}

class _OnBordingpageSixState extends State<OnBordingpageSix> {
  void initState() {
    super.initState();
    AppMetrica.reportEvent('onbording_6');
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
              page: 6,
            ),
            const Spacer(
              flex: 2,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'How satisfied are you with your '.tr,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
                children: [
                  TextSpan(
                      text: 'current fitness level?'.tr,
                      style: const TextStyle(
                        color: Color(0xff6B0496),
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      )),
                ],
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () => Navigator.of(context)
                  .push(createRoute(const OnBordingpageSevn())),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.5),
                child: WindowLineStack(
                  windowLineImage: MyImages.onboardingV2Page6Icon1,
                  textLineWindowOne: 'Completeli '.tr,
                  textLineWindowTwo: '- I feel fit and healthy'.tr,
                ),
              ),
            ),
            const SizedBox(
              height: 23,
            ),
            GestureDetector(
              onTap: () => Navigator.of(context)
                  .push(createRoute(const OnBordingpageSevn())),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.5),
                child: WindowLineStack(
                  windowLineImage: MyImages.onboardingV2Page6Icon2,
                  textLineWindowOne: 'Somewhat '.tr,
                  textLineWindowTwo:
                      "- I'd like to see some                 improvement".tr,
                ),
              ),
            ),
            const SizedBox(
              height: 23,
            ),
            GestureDetector(
              onTap: () => Navigator.of(context)
                  .push(createRoute(const OnBordingpageSevn())),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.5),
                child: WindowLineStack(
                  windowLineImage: MyImages.onboardingV2Page6Icon3,
                  textLineWindowOne: 'Not at all '.tr,
                  textLineWindowTwo: "- I'd like to see a major change".tr,
                ),
              ),
            ),
            const Spacer(
              flex: 2,
            ),
            //  const SkipToWelcomeButton(),
          ],
        ),
      ),
    );
  }
}
