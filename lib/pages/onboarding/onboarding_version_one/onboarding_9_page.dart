import 'dart:io';
import 'dart:ui';

import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
// import 'package:morningmagic/pages/onboarding/components/my_fade_animation.dart';
// import 'package:morningmagic/pages/onboarding/components/skip_to_welcome_button.dart';
import 'package:morningmagic/pages/onboarding/onboarding_version_one/onboarding_10_page.dart';
import 'package:morningmagic/resources/colors.dart';

import '../../../routing/app_routing.dart';

class OnBoarding9Page extends StatefulWidget {
  @override
  State<OnBoarding9Page> createState() => _OnBoarding9PageState();
}

class _OnBoarding9PageState extends State<OnBoarding9Page> {
  @override
  void initState() {
    super.initState();
    AppMetrica.reportEvent('onbording_7');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset("assets/images/onboarding/onb_bg_6.svg",
              fit: BoxFit.cover),
          ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "onb_9_text_1".tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.violet,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        alignment: Alignment.center,
                        width: 200,
                        height: 30,
                        child: Text(
                          "onb_9_text_2".tr,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.fromLTRB(10, 9, 10, 12),
                        child: Column(
                          children: [
                            Text(
                              "onb_9_text_3".tr.split("@d").first,
                              style: TextStyle(
                                  fontSize: Platform.isIOS ? 16 : 14,
                                  fontWeight: FontWeight.bold,
                                  color: HexColor("#7A4DA1")),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "onb_9_text_3".tr.split("@d").last,
                              style: TextStyle(
                                  fontSize: Platform.isIOS ? 14 : 12,
                                  color: HexColor("#592F72")),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.fromLTRB(10, 9, 10, 8),
                        child: Column(
                          children: [
                            Text(
                              "onb_9_text_4".tr.split("@d").first,
                              style: TextStyle(
                                  fontSize: Platform.isIOS ? 15 : 13,
                                  color: HexColor("#592F72")),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      SvgPicture.asset(
                          "assets/images/onboarding/onb_image_9.svg"),
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.white,
                              spreadRadius: 6,
                              blurRadius: 60,
                              offset: Offset(0, 0),
                            )
                          ],
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: AppColors.violetOnb,
                            minimumSize: const Size(double.infinity, 64),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .push(createRoute(const OnBoarding10Page()));
                          },

                          //Get.to(OnBoarding10Page()),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "onb_9_btn".tr,
                                style: TextStyle(
                                    fontSize: Platform.isIOS ? 15 : 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(width: 10),
                              const Icon(Icons.arrow_forward, size: 20),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // const AnimatedWidgetCustom(),
        ],
      ),
    );
  }
}
