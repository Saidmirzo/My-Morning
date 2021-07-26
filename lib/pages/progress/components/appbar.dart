import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/resources/colors.dart';

Widget appBarProgress(String title, {Color bgColor = Colors.transparent}) {
  return AppBar(
    backgroundColor: bgColor,
    foregroundColor: Colors.transparent,
    shadowColor: Colors.transparent,
    leading: IconButton(
        icon: Icon(
          Icons.keyboard_arrow_left_rounded,
          size: 40,
          color: AppColors.VIOLET,
        ),
        onPressed: Get.back),
    title: Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: AppColors.VIOLET,
        fontSize: Get.width * .06,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
