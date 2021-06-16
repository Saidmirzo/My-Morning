import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget bg() {
  String path = 'assets/images/interview';
  return Stack(
    children: [
      Positioned(
          bottom: 0,
          child: Image.asset('$path/clouds_1.png',
              width: Get.width, fit: BoxFit.cover)),
      Positioned(
          bottom: 0,
          child: Image.asset('$path/clouds_2.png',
              width: Get.width, fit: BoxFit.cover)),
    ],
  );
}
