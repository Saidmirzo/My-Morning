import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart';
import 'package:morningmagic/pages/onboarding/components/onboarding_v3_item.dart';
import 'package:morningmagic/pages/onboarding/onboarding_version_three/onboarding_page_5.dart';
import 'package:morningmagic/resources/svg_assets.dart';
import 'package:get/get.dart';

class OnboardingVersionThirdPageFourth extends StatefulWidget {
  const OnboardingVersionThirdPageFourth({Key key}) : super(key: key);

  @override
  State<OnboardingVersionThirdPageFourth> createState() =>
      _OnboardingVersionThirdPageFourthState();
}

class _OnboardingVersionThirdPageFourthState
    extends State<OnboardingVersionThirdPageFourth> {
  final List itemsInfo = [
    {
      "title1": 'onb_3_4_item_1_name_1'.tr,
      "title2": 'onb_3_4_item_1_name_2'.tr,
      "img": MyImages.onboardingV3Item3Bg,
    },
    {
      "title1": 'onb_3_4_item_2_name_1'.tr,
      "title2": 'onb_3_4_item_2_name_2'.tr,
      "img": MyImages.onboardingV3Item2Bg,
    },
    {
      "title1": 'onb_3_4_item_3_name_1'.tr,
      "title2": 'onb_3_4_item_3_name_2'.tr,
      "img": MyImages.onboardingV3Item1Bg,
    }
  ];
  void initState() {
    super.initState();
    AppMetrica.reportEvent('onbording_4');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(MyImages.onboardingV3OthersBg),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        children: [
          const Spacer(
            flex: 3,
          ),
          RichText(
            text: TextSpan(
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w700,
                fontFamily: 'Montserrat',
              ),
              text: 'Do you have trouble'.tr,
              children: [
                TextSpan(
                  text: 'concentrating?'.tr,
                  style: const TextStyle(
                    color: Color(0xff6b0495),
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          ...List.generate(
            3,
            (i) => OnboardingV3Item(
              title1: itemsInfo[i]["title1"],
              title2: itemsInfo[i]["title2"],
              img: itemsInfo[i]["img"],
              page: const OnboardingVersionThirdPageFifth(),
            ),
          ),
          const Spacer(
            flex: 9,
          ),
          const SizedBox(),
        ],
      ),
    );
  }
}
