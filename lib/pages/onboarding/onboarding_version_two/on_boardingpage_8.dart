import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/pages/onboarding/components/progress_bar.dart';
import 'package:morningmagic/pages/onboarding/components/window.dart';
import '../../../resources/svg_assets.dart';
import '../../../routing/app_routing.dart';
import 'on_boardingpage_9.dart';

class OnBordingpageEat extends StatefulWidget {
  const OnBordingpageEat({Key key}) : super(key: key);

  @override
  State<OnBordingpageEat> createState() => _OnBordingpageEatState();
}

class _OnBordingpageEatState extends State<OnBordingpageEat> {
  final List<Map<String, dynamic>> itemsInfo = [
    {
      "img": MyImages.onboardingV2Page8Icon1,
      "text1": "More  ".tr,
      "text2": "energy".tr,
      "text3": "",
    },
    {
      "img": MyImages.onboardingV2Page8Icon2,
      "text1": "More  ".tr,
      "text2": "productivity".tr,
      "text3": "",
    },
    {
      "img": MyImages.onboardingV2Page8Icon3,
      "text1": "More  ".tr,
      "text2": "mindfulness".tr,
      "text3": "",
    },
    {
      "img": MyImages.onboardingV2Page8Icon4,
      "text1": "More  ".tr,
      "text2": "Sleep".tr,
      "text3": "",
    },
  ];

  void initState() {
    super.initState();
    AppMetrica.reportEvent('onbording_8');
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
              page: 8,
            ),
            const Spacer(
              flex: 2,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'We hear you. What single change '.tr,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
                children: [
                  TextSpan(
                      text: 'would improve your life right now?'.tr,
                      style: const TextStyle(
                        color: Color(0xff6B0496),
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      )),
                  TextSpan(
                      text: '8tree'.tr,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      )),
                ],
              ),
            ),
            const Spacer(),
            Container(
              alignment: Alignment.center,
              width: (MediaQuery.of(context).size.width),
              padding: const EdgeInsets.symmetric(horizontal: 14.31),
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: List.generate(
                  4,
                  (i) => GestureDetector(
                    onTap: () => Navigator.of(context)
                        .push(createRoute(const OnBordingpageNine())),
                    child: Window(
                      windowiImage: itemsInfo[i]["img"],
                      windowTextOne: itemsInfo[i]["text1"],
                      windowTextTwo: itemsInfo[i]["text2"],
                      windowTextThree: itemsInfo[i]["text3"],
                    ),
                  ),
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
