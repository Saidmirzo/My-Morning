import 'dart:io';
import 'dart:ui';
import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:morningmagic/pages/onboarding/onboarding_version_one/onboarding_6_page.dart';
import 'package:morningmagic/resources/colors.dart';
import '../../../routing/app_routing.dart';
import 'onboarding_6_page.dart';

class OnBoarding3Page extends StatefulWidget {
  const OnBoarding3Page({Key key}) : super(key: key);

  @override
  State<OnBoarding3Page> createState() => _OnBoarding3PageState();
}

class _OnBoarding3PageState extends State<OnBoarding3Page> {
  bool _isOne = false;
  bool _isTwo = false;
  @override
  void initState() {
    super.initState();
    AppMetrica.reportEvent('onbording_3');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset("assets/images/onboarding/onb_bg_3.svg",
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
                      const Text(
                        "MY MORNING",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: 18),
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
                                text: "onb_3_text_1".tr.split("@d").first + " ",
                                style: TextStyle(
                                    fontSize: Platform.isIOS ? 18 : 16,
                                    fontWeight: FontWeight.bold,
                                    color: HexColor("#A57DBF")),
                              ),
                              const TextSpan(text: '\n'),
                              TextSpan(
                                text: "onb_3_text_1".tr.split("@d").last,
                                style: TextStyle(
                                    fontSize: Platform.isIOS ? 15 : 13,
                                    color: HexColor("#A57DBF")),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      AnimatedOpacity(
                        opacity: _isOne ? 1 : 0,
                        duration: const Duration(milliseconds: 500),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 171, 74, 212),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Text(
                                "onb_3_btn".tr.split("@d").first,
                                style: TextStyle(
                                    fontSize: Platform.isIOS ? 15 : 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        onEnd: () {
                          setState(() {
                            _isTwo = true;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      AnimatedOpacity(
                        opacity: _isTwo ? 1 : 0,
                        duration: const Duration(milliseconds: 500),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      "onb_5_text_1".tr.split("@d").first + " ",
                                  style: TextStyle(
                                      fontSize: Platform.isIOS ? 18 : 16,
                                      fontWeight: FontWeight.bold,
                                      color: HexColor("#A57DBF")),
                                ),
                                const TextSpan(text: '\n'),
                                TextSpan(
                                  text: "onb_5_text_1".tr.split("@d").last,
                                  style: TextStyle(
                                      fontSize: Platform.isIOS ? 15 : 13,
                                      color: HexColor("#A57DBF")),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
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
                            if (_isOne) {
                              if (_isTwo) {
                                Navigator.of(context)
                                    .push(createRoute(const OnBoarding6Page()));
                                // Get.to(OnBoarding6Page());
                              } else {
                                setState(() {
                                  _isTwo = true;
                                });
                              }
                            } else {
                              setState(() {
                                _isOne = true;
                              });
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Text(
                                  _isOne ? "onb_4_btn".tr : "onb_3_btn".tr,
                                  style: TextStyle(
                                      fontSize: Platform.isIOS ? 15 : 14,
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
          // const AnimatedWidgetCustom(),
        ],
      ),
    );
  }
}
