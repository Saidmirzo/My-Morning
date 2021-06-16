import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/widgets/primary_circle_button.dart';

class WelcomeTextSlide extends StatelessWidget {
  final PageController _pageController;

  WelcomeTextSlide(this._pageController);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacer(),
          Text(
            'welcome_page_title'.tr,
            style: TextStyle(
                color: Colors.white,
                fontSize: Get.width * .055,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 20),
          Text(
            'welcome_page_subtitle'.tr,
            style: TextStyle(color: Colors.white60, fontSize: Get.width * .042),
          ),
          Spacer(),
          Center(child: buildButton()),
          Spacer(),
          Center(
              child: SvgPicture.asset(
            'assets/images/yoga.svg',
            height: Get.height * .3,
          )),
        ],
      ),
    );
  }

  PrimaryCircleButton buildButton() {
    return PrimaryCircleButton(
      size: 40,
      icon: Icon(Icons.arrow_forward, color: AppColors.primary),
      onPressed: () {
        _pageController.nextPage(
            duration: Duration(milliseconds: 300), curve: Curves.easeIn);
      },
    );
  }
}
