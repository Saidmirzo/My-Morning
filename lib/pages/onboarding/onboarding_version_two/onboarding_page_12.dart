import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/pages/onboarding/components/continue_button.dart';
import 'package:morningmagic/pages/onboarding/onboarding_version_two/onboarding_page_13.dart';
import 'package:morningmagic/resources/svg_assets.dart';
import '../../../routing/app_routing.dart';

class OnboardingVersionSecondPageTwelve extends StatefulWidget {
  const OnboardingVersionSecondPageTwelve({Key key}) : super(key: key);

  @override
  State<OnboardingVersionSecondPageTwelve> createState() =>
      _OnboardingVersionSecondPageTwelveState();
}

class _OnboardingVersionSecondPageTwelveState
    extends State<OnboardingVersionSecondPageTwelve> {
  void initState() {
    super.initState();
    AppMetrica.reportEvent('onbording_12');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(MyImages.onboardingV2page12Bg),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            const Spacer(),
            RichText(
              text: TextSpan(
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Montserrat',
                ),
                text: "You're embarking on this journey ".tr,
                children: [
                  TextSpan(
                    text: 'to build more Energy'.tr,
                    style: const TextStyle(
                      color: Color(0xff6b0495),
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            CenterContent(),
            const Spacer(
              flex: 4,
            ),
            ContinueButton(
              callback: () {
                Navigator.of(context)
                    .push(createRoute(const OnboardingVersionSecondPage13()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CenterContent extends StatelessWidget {
  CenterContent({Key key}) : super(key: key);
  final List itemsInfo = [
    {
      "img": MyImages.onboardingV2page12Icon1,
      "text": "Fitness".tr,
      "w": 80.0,
      "h": 53.0,
    },
    {
      "img": MyImages.onboardingV2page12Icon2,
      "text": "Visualization".tr,
      "w": 96.0,
      "h": 53.0,
    },
    {
      "img": MyImages.onboardingV2page12Icon3,
      "text": "Meditationse".tr,
      "w": 60.0,
      "h": 54.0,
    },
    {
      "img": MyImages.onboardingV2page12Icon4,
      "text": "Reading".tr,
      "w": 73.0,
      "h": 84.0,
    },
    {
      "img": MyImages.onboardingV2page12Icon5,
      "text": "Notes".tr,
      "w": 84.0,
      "h": 83.0,
    },
    {
      "img": MyImages.onboardingV2page12Icon6,
      "text": "Affirmations".tr,
      "w": 61.0,
      "h": 84.0,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17),
      child: Wrap(
        runSpacing: 25,
        spacing: 8,
        children: List.generate(
          6,
          (i) => CenterContentItem(
            img: itemsInfo[i]["img"],
            text: itemsInfo[i]["text"],
            w: itemsInfo[i]["w"] * 1,
            h: itemsInfo[i]["h"] * 1,
          ),
        ),
      ),
    );
  }
}

class CenterContentItem extends StatelessWidget {
  const CenterContentItem({Key key, this.img, this.text, this.w, this.h})
      : super(key: key);
  final String img;
  final String text;
  final double w;
  final double h;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      width: 100,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            img,
            // width: size.width / 3 - 40,
            // fit: BoxFit.fitWidth,
            // width: double.maxFinite,
            // width: w,
            height: h,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontFamily: 'Montserrat',
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
