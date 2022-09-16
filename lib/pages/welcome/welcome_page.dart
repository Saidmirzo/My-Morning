import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/pages/welcome/slides/add_push_slide.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/widgets/pageview_dots.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'slides/name_input_slide.dart';
import 'slides/welcome_text_slide.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((value) {
      AppMetrica.reportEvent('first_open');
      value.setBool('isFirstOpen', true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.Bg_Gradient_2),
        child: Stack(
          children: [
            buildClouds(),
            SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 5),
                  PageViewDots(
                    controller: pageController,
                    countPages: 3,
                    activeColor: Colors.white,
                    inactiveColor: Colors.white24,
                  ),
                  Expanded(
                    child: PageView(
                      controller: pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        AddPushSlide(pageController),
                        NameInputSlide(pageController),
                        WelcomeTextSlide(pageController),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Positioned buildClouds() {
    return Positioned(
      bottom: 0,
      child: SizedBox(
        width: Get.width,
        child: Image.asset(
          'assets/images/auth/clouds.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
