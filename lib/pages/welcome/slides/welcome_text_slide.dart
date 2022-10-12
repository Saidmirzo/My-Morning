import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:morningmagic/pages/menu/main_menu.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/services/ab_testing_service.dart';
import 'package:morningmagic/widgets/primary_circle_button.dart';

import '../../paywall/paywall_v2/paywall_v2_oto.dart';

class WelcomeTextSlide extends StatelessWidget {
  final PageController _pageController;

  const WelcomeTextSlide(this._pageController);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(),
          Text(
            'welcome_page_title'.tr,
            style: TextStyle(color: Colors.white, fontSize: Get.width * .055, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 20),
          Text(
            'welcome_page_subtitle'.tr,
            style: TextStyle(color: Colors.white60, fontSize: Get.width * .042),
          ),
          const Spacer(),
          // Кнопка Далее
          Center(child: PrimaryCircleButton(
            size: 40,
            icon: const Icon(Icons.arrow_forward, color: AppColors.primary),
            onPressed: () async {
              if (ABTestingService.paywallVersion == 'v2') {
                Get.to(() => PaywallV2OneTimeOffer());
              }
              else {
                Get.to(() => const MainMenuPage());
              }
            },
          )),
          const Spacer(),
          Center(
              child: SvgPicture.asset(
            'assets/images/yoga.svg',
            height: Get.height * .3,
          )),
        ],
      ),
    );
  }
}
