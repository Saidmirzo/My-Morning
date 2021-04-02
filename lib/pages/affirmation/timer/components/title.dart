import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/widgets/customText.dart';

Widget buildTitleWidget(String text) {
  return Column(
    children: [
      Container(
        margin: const EdgeInsets.only(bottom: 16.0),
        width: Get.width * 3 / 4,
        child: CustomText(text: text, size: 22),
      ),
      SizedBox(height: 24),
    ],
  );
}
