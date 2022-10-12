import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/model/user/user.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/pages/onboarding/components/onboarding_v3_item.dart';
import 'package:morningmagic/pages/paywall/new_paywall.dart';
import 'package:morningmagic/resources/svg_assets.dart';
import 'package:get/get.dart';

class OnboardingVersionThirdPageFifth extends StatefulWidget {
  const OnboardingVersionThirdPageFifth({Key key}) : super(key: key);

  @override
  State<OnboardingVersionThirdPageFifth> createState() =>
      _OnboardingVersionThirdPageFifthState();
}

class _OnboardingVersionThirdPageFifthState
    extends State<OnboardingVersionThirdPageFifth> {
  @override
  void initState() {
    MyDB().getBox().put(MyResource.USER_KEY, User(""));

    super.initState();
    AppMetrica.reportEvent('onbording_5');
  }

  final List itemsInfo = [
    {
      "title1": 'onb_3_5_item_1_name_1'.tr,
      "title2": 'onb_3_5_item_1_name_2'.tr,
      "img": MyImages.onboardingV3Item3Bg,
    },
    {
      "title1": 'onb_3_5_item_2_name_1'.tr,
      "title2": 'onb_3_5_item_2_name_2'.tr,
      "img": MyImages.onboardingV3Item2Bg,
    },
    {
      "title1": 'onb_3_5_item_3_name_1'.tr,
      "title2": 'onb_3_5_item_3_name_2'.tr,
      "img": MyImages.onboardingV3Item1Bg,
    }
  ];
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
              text: 'What do you want to '.tr,
              children: [
                TextSpan(
                  text: 'to get out of My Morning?'.tr,
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
              page: NewPaywall(),
              isLast: true,
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
