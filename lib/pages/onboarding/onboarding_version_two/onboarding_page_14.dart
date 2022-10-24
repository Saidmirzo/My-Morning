import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/model/user/user.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/pages/menu/main_menu.dart';
import 'package:morningmagic/pages/paywall/new_paywall.dart';
import 'package:morningmagic/resources/svg_assets.dart';
import 'package:morningmagic/routing/app_routing.dart';

import '../../../services/ab_testing_service.dart';

class OnboardingVersionSecondPage14 extends StatefulWidget {
  const OnboardingVersionSecondPage14({Key key}) : super(key: key);

  @override
  State<OnboardingVersionSecondPage14> createState() => _OnboardingVersionSecondPage14State();
}

class _OnboardingVersionSecondPage14State extends State<OnboardingVersionSecondPage14> {
  @override
  void initState() {
    MyDB().getBox().put(MyResource.USER_KEY, User(""));
    super.initState();
    AppMetrica.reportEvent('onbording_14');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(MyImages.onboardingV2page14Bg),
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
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Montserrat',
                ),
                text: "Just ".tr,
                children: [
                  TextSpan(
                    text: '30 minutes every day for a year '.tr,
                    style: const TextStyle(
                      color: Color(0xff6b0495),
                    ),
                  ),
                  TextSpan(
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Montserrat',
                    ),
                    text: "will change your life dramatically!".tr,
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              width: double.maxFinite,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 25),
              margin: const EdgeInsets.symmetric(horizontal: 13),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.67),
                borderRadius: BorderRadius.circular(14.88),
              ),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(
                    color: Color(0xff020001),
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Montserrat',
                  ),
                  text: "Ready".tr,
                  children: [
                    TextSpan(
                      text: 'to start?'.tr,
                      style: const TextStyle(
                        color: Color(0xff6b0495),
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(
              flex: 4,
            ),
            GestureDetector(
              onTap: () {
                AppRouting.replace(const MainMenuPage());
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ABTestingService.getPaywall()),
                );
              },
              child: Container(
                width: double.maxFinite,
                margin: const EdgeInsets.only(left: 14.3, right: 14.3, bottom: 39),
                padding: const EdgeInsets.symmetric(
                  vertical: 22.23,
                ),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xff6B0496),
                  borderRadius: BorderRadius.circular(19),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.53),
                      blurRadius: 50,
                      spreadRadius: 10,
                      offset: const Offset(5, 20),
                    ),
                  ],
                ),
                child: Text(
                  'lets go'.tr,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
