import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget titleQuestion(String title) => Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: Get.height * 0.023,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
    );
