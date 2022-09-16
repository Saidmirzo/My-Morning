import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/pages/onboarding/components/line_window.dart';
import 'package:morningmagic/pages/onboarding/components/progress_bar.dart';
import '../../../resources/svg_assets.dart';
import '../../../routing/app_routing.dart';
import 'on_boardingpage_5.dart';

class OnBordingpageFore extends StatefulWidget {
  const OnBordingpageFore({Key key}) : super(key: key);

  @override
  State<OnBordingpageFore> createState() => _OnBordingpageForeState();
}

class _OnBordingpageForeState extends State<OnBordingpageFore> {
  void initState() {
    super.initState();
    AppMetrica.reportEvent('onbording_4');
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
              page: 4,
            ),
            const Spacer(
              flex: 2,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'How much time '.tr,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
                children: [
                  TextSpan(
                      text: 'do you have '.tr,
                      style: const TextStyle(
                        color: Color(0xff6B0496),
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      )),
                  TextSpan(
                    text: 'at the start of your day?'.tr,
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
                  .push(createRoute(const OnBordingpageFive())),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.5),
                child: LineWindow(
                  imageLineWindow: MyImages.onboardingV2Page4Icon1,
                  lineWindowTextOne: '0-10 ',
                  linewindowTextTwo: 'minutes'.tr,
                ),
              ),
            ),
            const SizedBox(
              height: 13,
            ),
            GestureDetector(
              onTap: () => Navigator.of(context)
                  .push(createRoute(const OnBordingpageFive())),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.5),
                child: LineWindow(
                  imageLineWindow: MyImages.onboardingV2Page4Icon2,
                  lineWindowTextOne: '10-20 ',
                  linewindowTextTwo: 'minutes'.tr,
                ),
              ),
            ),
            const SizedBox(
              height: 13,
            ),
            GestureDetector(
              onTap: () => Navigator.of(context)
                  .push(createRoute(const OnBordingpageFive())),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.5),
                child: LineWindow(
                  imageLineWindow: MyImages.onboardingV2Page4Icon3,
                  lineWindowTextOne: '20-30 ',
                  linewindowTextTwo: 'minutes'.tr,
                ),
              ),
            ),
            const SizedBox(
              height: 13,
            ),
            GestureDetector(
              onTap: () => Navigator.of(context)
                  .push(createRoute(const OnBordingpageFive())),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.5),
                child: LineWindow(
                  imageLineWindow: MyImages.onboardingV2Page4Icon4,
                  lineWindowTextOne: '30+ ',
                  linewindowTextTwo: 'minutes'.tr,
                ),
              ),
            ),
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
