import 'dart:io';
import 'dart:ui';
import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/model/user/user.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/pages/menu/main_menu.dart';
import 'package:morningmagic/pages/paywall/new_paywall.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/routing/app_routing.dart';
import 'package:morningmagic/services/analitics/all.dart';

import '../../../services/ab_testing_service.dart';

class OnBoarding11Page extends StatefulWidget {
  @override
  State<OnBoarding11Page> createState() => _OnBoarding11PageState();
}

class _OnBoarding11PageState extends State<OnBoarding11Page> {
  @override
  void initState() {
    super.initState();
    AppMetrica.reportEvent('onbording_9');
    MyDB().getBox().put(MyResource.USER_KEY, User(""));
    appAnalitics.logEvent('first_name');
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
                        "onb_11_text_1".tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                      const Spacer(),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                        child: Text(
                          "onb_11_text_2".tr.split("@d").last,
                          style: TextStyle(
                              fontSize: Platform.isIOS ? 20 : 18,
                              color: HexColor("#592F72"),
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      // const SizedBox(height: 70),
                      const Spacer(),
                      Image.asset("assets/images/onboarding/onb_image_11.png"),
                      const Spacer(
                        flex: 2,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                        child: Text(
                          "onb_11_text_3".tr,
                          style: TextStyle(
                              fontSize: Platform.isIOS ? 20 : 18,
                              color: HexColor("#592F72"),
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
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
                            AppRouting.replace(const MainMenuPage());
                            Get.to(ABTestingService.getPaywall());
                            //Get.to(const PaymentPage());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "onb_11_btn".tr,
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
