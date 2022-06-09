import 'dart:io';
import 'dart:ui';

import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:morningmagic/pages/onboarding/onboarding_7_page.dart';
import 'package:morningmagic/resources/colors.dart';

class OnBoarding6Page extends StatefulWidget {
  @override
  State<OnBoarding6Page> createState() => _OnBoarding6PageState();
}

class _OnBoarding6PageState extends State<OnBoarding6Page> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AppMetrica.reportEvent('onbording_4');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset("assets/images/onboarding/onb_bg_6.svg", fit: BoxFit.cover),
          ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "onb_6_text_1".tr,
                        style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white, fontSize: 23),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.VIOLET,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        alignment: Alignment.center,
                        width: 200,
                        height: 35,
                        child: Text(
                          "onb_6_text_2".tr,
                          style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                        child: Column(
                          children: [
                            Text(
                              "onb_6_text_3".tr.split("@d").first,
                              style: TextStyle(fontSize: Platform.isIOS ? 19 : 17, fontWeight: FontWeight.bold, color: HexColor("#7A4DA1")),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "onb_6_text_3".tr.split("@d").last,
                              style: TextStyle(fontSize: Platform.isIOS ? 17 : 15, color: HexColor("#592F72")),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                        child: Column(
                          children: [
                            Text(
                              "onb_6_text_4".tr.split("@d").first,
                              style: TextStyle(fontSize: Platform.isIOS ? 17 : 15, color: HexColor("#592F72")),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      SvgPicture.asset("assets/images/onboarding/onb_image_6.svg"),
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
                          onPressed: () => Get.to(OnBoarding7Page()),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "onb_6_btn".tr,
                                style: TextStyle(fontSize: Platform.isIOS ? 15 : 14, fontWeight: FontWeight.bold),
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
