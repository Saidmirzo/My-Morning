import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget bg() {
  return Stack(
    children: [
      Positioned(
          bottom: 0,
          child: Image.asset('assets/images/reading/clouds.png',
              width: Get.width, fit: BoxFit.cover)),
      Positioned(
        bottom: 0,
        child: Image.asset('assets/images/reading/mountain1.png',
            width: Get.width, fit: BoxFit.cover),
      ),
      Positioned(
        bottom: 0,
        child: Image.asset('assets/images/reading/mountain2.png',
            width: Get.width, fit: BoxFit.cover),
      ),
      Positioned(
          bottom: 0,
          child: Image.asset('assets/images/reading/main.png',
              width: Get.width, fit: BoxFit.cover)),
    ],
  );
}

Widget bgNight() {
  return Stack(
    children: [
      Positioned(
          bottom: 0,
          child: Image.asset('assets/images/reading_night/clouds.png',
              width: Get.width, fit: BoxFit.cover)),
      Positioned(
        bottom: 0,
        child: Image.asset('assets/images/reading/mountain1.png',
            width: Get.width, fit: BoxFit.cover),
      ),
      Positioned(
        bottom: 0,
        child: Image.asset('assets/images/reading/mountain2.png',
            width: Get.width, fit: BoxFit.cover),
      ),
      Positioned(
          bottom: 0,
          child: Image.asset('assets/images/reading_night/main.png',
              width: Get.width, fit: BoxFit.cover)),
    ],
  );
}
