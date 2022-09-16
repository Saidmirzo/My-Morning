import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/pages/onboarding/components/progress_bar.dart';
import 'package:morningmagic/pages/onboarding/components/window.dart';
import 'package:morningmagic/resources/svg_assets.dart';
import '../../../routing/app_routing.dart';
import 'on_boardingpage_3.dart';

class OnBordingpageTwo extends StatefulWidget {
  const OnBordingpageTwo({Key key}) : super(key: key);

  @override
  State<OnBordingpageTwo> createState() => _OnBordingpageTwoState();
}

class _OnBordingpageTwoState extends State<OnBordingpageTwo> {
  final List<Map<String, dynamic>> itemsInfo = [
    {
      "img": MyImages.onboardingV2Page2Icon1,
      "text1": "7 ",
      "text2": 'hours or'.tr,
      "text3": 'less'.tr,
    },
    {
      "img": MyImages.onboardingV2Page2Icon2,
      "text1": "7-9",
      "text2": 'hours'.tr,
      "text3": "",
    },
    {
      "img": MyImages.onboardingV2Page2Icon3,
      "text1": "9-12",
      "text2": 'hours'.tr,
      "text3": "",
    },
    {
      "img": MyImages.onboardingV2Page2Icon4,
      "text1": " 12 ",
      "text2": 'hours or'.tr,
      "text3": 'more'.tr,
    },
  ];

  void initState() {
    super.initState();
    AppMetrica.reportEvent('onbording_2');
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
              page: 2,
            ),
            const Spacer(
              flex: 2,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'How much'.tr,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Montserrat',
                ),
                children: [
                  TextSpan(
                      text: 'sleep'.tr,
                      style: const TextStyle(
                        color: Color(0xff6B0496),
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Montserrat',
                      )),
                  TextSpan(
                      text: 'do you usually get at hight'.tr,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Montserrat',
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
                        .push(createRoute(const OnBordingpageThree())),
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
            //  const SkipToWelcomeButton(),
          ],
        ),
      ),
    );
  }
}
