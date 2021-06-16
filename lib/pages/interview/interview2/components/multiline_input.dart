import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/resources/colors.dart';

Container multilineInput(TextEditingController _controller,
    {String hint, int minLines = 5}) {
  return Container(
    width: Get.width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.white.withOpacity(0.4),
    ),
    child: Container(
      padding: EdgeInsets.all(19),
      child: TextField(
        controller: _controller,
        minLines: minLines,
        maxLines: 10,
        cursorColor: AppColors.VIOLET,
        keyboardType: TextInputType.text,
        textAlign: TextAlign.left,
        style: TextStyle(
            fontSize: Get.height * 0.02,
            fontStyle: FontStyle.normal,
            color: AppColors.VIOLET,
            decoration: TextDecoration.none),
        decoration: InputDecoration(hintText: hint, border: InputBorder.none),
      ),
    ),
  );
}
