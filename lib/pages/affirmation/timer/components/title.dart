import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/widgets/customText.dart';

Widget buildTitleWidget(String text, BuildContext context) {
  return SizedBox(
      height: MediaQuery.of(context).size.height / 8,
      width: Get.width * 3 / 4,
      child: CustomText(text: text, size: 22));
}
