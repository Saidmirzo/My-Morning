import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget bg() {
  return Container(
    child: Stack(
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
    ),
  );
}
