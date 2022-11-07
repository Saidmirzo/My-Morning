// ignore_for_file: use_key_in_widget_constructors

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:morningmagic/resources/colors.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double size;

  const CustomText({
    @required this.text,
    @required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      maxLines: 5,
      minFontSize: 14,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: AppColors.white,
        fontStyle: FontStyle.normal,
        fontSize: size,
      ),
    );
  }
}
