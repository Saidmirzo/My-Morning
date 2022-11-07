import 'dart:io';
import 'dart:ui';
import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:morningmagic/pages/onboarding/onboarding_version_one/onboarding_3_page.dart';
import 'package:morningmagic/resources/colors.dart';
import '../../../routing/app_routing.dart';

class OnBoarding2Page extends StatefulWidget {
  const OnBoarding2Page({Key key}) : super(key: key);

  @override
  State<OnBoarding2Page> createState() => _OnBoarding2PageState();
}

class _OnBoarding2PageState extends State<OnBoarding2Page> {
  @override
  void initState() {
    super.initState();
    AppMetrica.reportEvent('onbording_2');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset("assets/images/onboarding/onb_bg_2.svg",
              fit: BoxFit.cover),
          ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 9),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "MY MORNING",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                      const Spacer(),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 17),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "onb_2_text_1".tr.split("@d").first + " ",
                                style: TextStyle(
                                    fontSize: Platform.isIOS ? 17 : 15,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        AppColors.violetOnb.withOpacity(0.5)),
                              ),
                              const TextSpan(text: '\n'),
                              TextSpan(
                                text: "onb_2_text_1".tr.split("@d").last,
                                style: TextStyle(
                                    fontSize: Platform.isIOS ? 16 : 14,
                                    color:
                                        AppColors.violetOnb.withOpacity(0.5)),
                              )
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      SvgPicture.asset(
                          "assets/images/onboarding/onb_image_2.svg"),
                      const Spacer(
                        flex: 2,
                      ),
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
                                .push(createRoute(const OnBoarding3Page()));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Text(
                                  "onb_2_btn".tr,
                                  style: TextStyle(
                                      fontSize: Platform.isIOS ? 15 : 13,
                                      fontWeight: FontWeight.bold),
                                ),
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
        ],
      ),
    );
  }
}
