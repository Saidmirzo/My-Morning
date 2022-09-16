// ignore_for_file: use_key_in_widget_constructors

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
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: AppColors.WHITE,
        fontStyle: FontStyle.normal,
        fontSize: size,
      ),
    );
  }
}
