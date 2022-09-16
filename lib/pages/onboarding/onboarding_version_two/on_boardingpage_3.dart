import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/pages/onboarding/components/progress_bar.dart';
import 'package:morningmagic/pages/onboarding/components/window.dart';
import '../../../resources/svg_assets.dart';
import '../../../routing/app_routing.dart';
import 'on_boardingpage_4.dart';

class OnBordingpageThree extends StatefulWidget {
  const OnBordingpageThree({Key key}) : super(key: key);

  @override
  State<OnBordingpageThree> createState() => _OnBordingpageThreeState();
}

class _OnBordingpageThreeState extends State<OnBordingpageThree> {
  final List<Map<String, dynamic>> itemsInfo = [
    {
      "img": MyImages.onboardingV2Page3Icon3,
      "text1": 'Always'.tr,
      "text2": "",
      "text3": "",
    },
    {
      "img": MyImages.onboardingV2Page3Icon2,
      "text1": 'Usually'.tr,
      "text2": "",
      "text3": "",
    },
    {
      "img": MyImages.onboardingV2Page3Icon1,
      "text1": 'Sometimes'.tr,
      "text2": "",
      "text3": "",
    },
    {
      "img": MyImages.onboardingV2Page3Icon4,
      "text1": 'Rarely'.tr,
      "text2": "",
      "text3": "",
    },
  ];
  void initState() {
    super.initState();
    AppMetrica.reportEvent('onbording_3');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // padding: const EdgeInsets.all(14.5),
        height: MediaQuery.of(context).size.height,
        // width: double.maxFinite,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(MyImages.onboardingV2page2Bg),
              fit: BoxFit.fill),
        ),
        child: Column(
          children: [
            const Spacer(),
            const ProgressBar(
              page: 3,
            ),
            const Spacer(
              flex: 2,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'Got it! Do you'.tr,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
                children: [
                  TextSpan(
                      text: 'wake up'.tr,
                      style: const TextStyle(
                        color: Color(0xff6B0496),
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      )),
                  TextSpan(
                      text: 'feeling well-rested?'.tr,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ))
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
                        .push(createRoute(const OnBordingpageFore())),
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
            // const SkipToWelcomeButton(),
          ],
        ),
      ),
    );
  }
}
