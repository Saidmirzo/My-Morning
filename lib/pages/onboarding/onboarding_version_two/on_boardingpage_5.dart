import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/pages/onboarding/components/line_window_stacks.dart';
import 'package:morningmagic/pages/onboarding/components/progress_bar.dart';
import '../../../resources/svg_assets.dart';
import '../../../routing/app_routing.dart';
import 'on_boardingpage_6.dart';

class OnBordingpageFive extends StatefulWidget {
  const OnBordingpageFive({Key key}) : super(key: key);

  @override
  State<OnBordingpageFive> createState() => _OnBordingpageFiveState();
}

class _OnBordingpageFiveState extends State<OnBordingpageFive> {
  void initState() {
    super.initState();
    AppMetrica.reportEvent('onbording_5');
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
              page: 5,
            ),
            const Spacer(
              flex: 2,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'Understood! Throughout your day, how are your'.tr,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
                children: [
                  TextSpan(
                      text: 'energy levels'.tr,
                      style: const TextStyle(
                        color: Color(0xff6B0496),
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      )),
                  TextSpan(
                      text: 'energy levels two'.tr,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      )),
                ],
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () => Navigator.of(context)
                  .push(createRoute(const OnBordingpageSix())),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.5),
                child: WindowLineStack(
                  windowLineImage: MyImages.onboardingV2Page5Icon1,
                  textLineWindowOne: 'High '.tr,
                  textLineWindowTwo: '- energized troughot the day'.tr,
                ),
              ),
            ),
            const SizedBox(
              height: 23,
            ),
            GestureDetector(
              onTap: () => Navigator.of(context)
                  .push(createRoute(const OnBordingpageSix())),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.5),
                child: WindowLineStack(
                  windowLineImage: MyImages.onboardingV2Page5Icon2,
                  textLineWindowOne: 'Medium '.tr,
                  textLineWindowTwo: '- i have bursts of energy'.tr,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () => Navigator.of(context)
                  .push(createRoute(const OnBordingpageSix())),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.5),
                child: WindowLineStack(
                  windowLineImage: MyImages.onboardingV2Page5Icon3,
                  textLineWindowOne: 'Low '.tr,
                  textLineWindowTwo: '- my energy fades troughout the day'.tr,
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
