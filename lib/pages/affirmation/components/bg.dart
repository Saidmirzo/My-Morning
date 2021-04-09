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
        child: Image.asset('$path/mountain2.png',
            width: Get.width, fit: BoxFit.cover),
      ),
      Positioned(
          bottom: 0,
          child: Image.asset('$path/main.png',
              width: Get.width, fit: BoxFit.cover)),
    ],
  );
}
