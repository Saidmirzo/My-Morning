import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget bg() {
  return Stack(
    children: [
      Positioned(
          top: 0,
          child: Image.asset(
            'assets/images/meditation/clouds.png',
            fit: BoxFit.cover,
            width: Get.width,
          )),
      Positioned(
        bottom: 0,
        child: Image.asset('assets/images/meditation/mountain1.png',
            width: Get.width, fit: BoxFit.cover),
      ),
      Positioned(
        bottom: 0,
        child: Image.asset('assets/images/meditation/mountain2.png',
            width: Get.width, fit: BoxFit.cover),
      ),
      Positioned(
          bottom: 0,
          child: Image.asset('assets/images/meditation/main.png',
              width: Get.width, fit: BoxFit.cover)),
    ],
  );
}

Widget bgNightMeditation() {
  return Stack(
    children: [
      Positioned(
          bottom: 0,
          child: Image.asset('assets/images/meditation/clouds_night.png',
              width: Get.width, fit: BoxFit.cover)),
      Positioned(
        bottom: 0,
        child: Image.asset('assets/images/meditation/mountain1_night.png',
            width: Get.width, fit: BoxFit.cover),
      ),
      Positioned(
        bottom: 0,
        child: Image.asset('assets/images/meditation/mountain2_night.png',
            width: Get.width, fit: BoxFit.cover),
      ),
      Positioned(
          bottom: 25,
          left: Get.width * .1,
          right: Get.width * .1,
          child: Image.asset('assets/images/meditation/main_night.png',
              width: Get.width * .8, fit: BoxFit.cover)),
    ],
  );
}
