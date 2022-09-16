import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget bg() {
  return Stack(
    children: [
      Positioned(
          bottom: 0,
          child: Image.asset('assets/images/fitnes/clouds.png',
              width: Get.width, fit: BoxFit.cover)),
      Positioned(
        bottom: 0,
        child: Image.asset('assets/images/fitnes/mountain1.png',
            width: Get.width, fit: BoxFit.cover),
      ),
      Positioned(
        bottom: 0,
        child: Image.asset('assets/images/fitnes/mountain2.png',
            width: Get.width, fit: BoxFit.cover),
      ),
      Positioned(
          bottom: 0,
          child: Image.asset('assets/images/fitnes/main1.png',
              scale: 5, width: Get.width, fit: BoxFit.cover)),
    ],
  );
}
