import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget bg() {
  String path = 'assets/images/affirmation';
  return Stack(
    children: [
      Positioned(
          bottom: 0,
          child: Image.asset('$path/clouds.png',
              width: Get.width, fit: BoxFit.cover)),
      Positioned(
        bottom: 0,
        child: Image.asset('$path/mountain1.png',
            width: Get.width, fit: BoxFit.cover),
      ),
      Positioned(
        bottom: 0,
        child: Image.asset(
          '$path/mountain2.png',
          width: Get.width,
          fit: BoxFit.cover,
        ),
      ),
      Positioned(
        bottom: 0,
        child: Image.asset(
          '$path/avatar_bg.png',
          width: Get.width,
          fit: BoxFit.cover,
        ),
      ),
      Positioned(
          bottom: 0,
          right: Get.width / 4.518072289,
          left: Get.width / 4.518072289,
          child: Image.asset(
            '$path/main.png',
            width: Get.width,
          )),
    ],
  );
}
