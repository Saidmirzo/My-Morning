import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/resources/colors.dart';

Widget appBarProgress(String title, {Color bgColor = Colors.transparent}) {
  return AppBar(
    backgroundColor: bgColor,
    foregroundColor: Colors.transparent,
    shadowColor: Colors.transparent,
    leading: IconButton(
        icon: const Icon(
          Icons.west,
          size: 30,
          color: Colors.white,
        ),
        onPressed: Get.back),
    title: Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: AppColors.violet,
        fontSize: Get.width * .06,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
