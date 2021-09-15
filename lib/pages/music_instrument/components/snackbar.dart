import 'package:flutter/material.dart';
import 'package:morningmagic/resources/colors.dart';

Widget snackText(String text, {Color textColor = AppColors.WHITE}) {
  return Text(text,
      textAlign: TextAlign.center, style: TextStyle(color: textColor));
}
