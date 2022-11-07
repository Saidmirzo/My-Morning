import 'dart:io';
import 'dart:ui';
import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:morningmagic/pages/onboarding/onboarding_version_one/onboarding_11_page.dart';
import 'package:morningmagic/resources/colors.dart';
import '../../../routing/app_routing.dart';

class OnBoarding10Page extends StatefulWidget {
  const OnBoarding10Page({Key key}) : super(key: key);

  @override
  State<OnBoarding10Page> createState() => _OnBoarding10PageState();
}

class _OnBoarding10PageState extends State<OnBoarding10Page> {
  @override
  void initState() {
    super.initState();
    AppMetrica.reportEvent('onbording_8');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset("assets/images/onboarding/onb_bg_10.svg",
              fit: BoxFit.cover),
          ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "onb_10_text_1".tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: 23),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 15),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.violet,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        alignment: Alignment.center,
                        width: 200,
                        height: 35,
                        child: Text(
                          "onb_10_text_2".tr,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                        child: Column(
                          children: [
                            Text(
                              "onb_10_text_3".tr.split("@d").first,
                              style: TextStyle(
                                  fontSize: Platform.isIOS ? 19 : 17,
                                  fontWeight: FontWeight.bold,
                                  color: HexColor("#7A4DA1")),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "onb_10_text_3".tr.split("@d").last,
                              style: TextStyle(
                                  fontSize: Platform.isIOS ? 17 : 15,
                                  color: HexColor("#592F72")),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                        child: Column(
                          children: [
                            Text(
                              "onb_10_text_4".tr.split("@d").first,
                              style: TextStyle(
                                  fontSize: Platform.isIOS ? 17 : 15,
                                  color: HexColor("#592F72")),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Expanded(
                          flex: 15,
                          child: SvgPicture.asset(
                              "assets/images/onboarding/onb_image_10.svg")),
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
                                .push(createRoute(OnBoarding11Page()));
                          },

                          //Get.to(OnBoarding11Page()),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "onb_10_btn".tr,
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
