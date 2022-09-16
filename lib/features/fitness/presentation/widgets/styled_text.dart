import 'package:flutter/material.dart';
import 'package:morningmagic/resources/colors.dart';

class StyledText extends StatelessWidget {
  final String data;
  final double fontSize;
  final Color color;
  final TextAlign textAlign;
  final FontWeight fontWeight;

  const StyledText(
    this.data, {
    Key key,
    this.fontSize = 12,
    this.color = AppColors.VIOLET,
    this.textAlign = TextAlign.start,
    this.fontWeight = FontWeight.w400,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize,
        fontStyle: FontStyle.normal,
        color: color,
        fontWeight: fontWeight,
      ),
    );
  }
}
