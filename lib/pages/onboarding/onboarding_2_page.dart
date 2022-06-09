import 'dart:io';
import 'dart:ui';

import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:morningmagic/pages/onboarding/onboarding_3_page.dart';
import 'package:morningmagic/resources/colors.dart';

class OnBoarding2Page extends StatefulWidget {
  @override
  State<OnBoarding2Page> createState() => _OnBoarding2PageState();
}

class _OnBoarding2PageState extends State<OnBoarding2Page> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AppMetrica.reportEvent('onbording_2');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset("assets/images/onboarding/onb_bg_2.svg", fit: BoxFit.cover),
          ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "MY MORNING",
                        style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white, fontSize: 23),
                        textAlign: TextAlign.center,
                      ),
                      const Spacer(),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.all(20),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "onb_2_text_1".tr.split("@d").first + " ",
                                style: TextStyle(fontSize: Platform.isIOS ? 22 : 19, fontWeight: FontWeight.bold, color: AppColors.VIOLET_ONB.withOpacity(0.5)),
                              ),
                              TextSpan(
                                text: "onb_2_text_1".tr.split("@d").last,
                                style: TextStyle(fontSize: Platform.isIOS ? 20 : 17, color: AppColors.VIOLET_ONB.withOpacity(0.5)),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 70),
                      SvgPicture.asset("assets/images/onboarding/onb_image_2.svg"),
                      const SizedBox(height: 70),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
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
                            primary: AppColors.VIOLET_ONB,
                            minimumSize: Size(double.infinity, 64),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () => Get.to(OnBoarding3Page()),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Text(
                                  "onb_2_btn".tr,
                                  style: TextStyle(fontSize: Platform.isIOS ? 15 : 14, fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Icon(Icons.arrow_forward, size: 20),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
