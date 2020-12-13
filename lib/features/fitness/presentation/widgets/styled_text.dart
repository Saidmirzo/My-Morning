import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:morningmagic/resources/colors.dart';

class StyledText extends StatelessWidget {
  final String data;
  final double fontSize;
  final Color color;
  final TextAlign textAlign;

  const StyledText(this.data,
      {Key key,
      this.fontSize = 12,
      this.color = AppColors.VIOLET,
      this.textAlign = TextAlign.start})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize,
        fontFamily: 'rex',
        fontStyle: FontStyle.normal,
        color: color,
      ),
    );
  }
}
