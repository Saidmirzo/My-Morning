import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/pages/welcome/slides/add_push_slide.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/widgets/pageview_dots.dart';

import 'slides/name_input_slide.dart';
import 'slides/welcome_text_slide.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.Bg_Gradient_2),
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
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        NameInputSlide(pageController),
                        WelcomeTextSlide(pageController),
                        AddPushSlide(),
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
      child: Container(
        width: Get.width,
        child: Image.asset(
          'assets/images/auth/clouds.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
