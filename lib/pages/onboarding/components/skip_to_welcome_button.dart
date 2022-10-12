import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/pages/menu/main_menu.dart';
import 'package:morningmagic/pages/welcome/welcome_page.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/routing/app_routing.dart';

class SizedBox extends StatelessWidget {
  const SizedBox({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppRouting.replace(const MainMenuPage());
        Get.to(() => const WelcomePage());
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: Text(
          "skip".tr,
          style: const TextStyle(
            color: AppColors.VIOLET,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
