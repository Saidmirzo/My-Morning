import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget bg() {
  return Stack(
    children: [
      Positioned(
          bottom: 0,
          child: Image.asset('assets/images/diary/clouds.png',
              width: Get.width, fit: BoxFit.cover)),
      Positioned(
        bottom: 0,
        child: Image.asset('assets/images/diary/mountain1.png',
            width: Get.width, fit: BoxFit.cover),
      ),
      Positioned(
        bottom: 0,
        child: Image.asset('assets/images/diary/mountain2.png',
            width: Get.width, fit: BoxFit.cover),
      ),
      Positioned(
          bottom: 0,
          child: Image.asset('assets/images/diary/main.png',
              width: Get.width, fit: BoxFit.cover)),
    ],
  );
}
