import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/resources/colors.dart';

import 'arcProgressBarPainter.dart';

class ArcProgressBar extends StatelessWidget {
  final String text;
  final Color textColor;

  const ArcProgressBar({
    Key key,
    @required this.text,
    this.textColor = AppColors.lightViolet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: CustomPaint(
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                fontSize: Get.height * 0.04,
                fontStyle: FontStyle.normal,
                color: textColor,
                fontWeight: FontWeight.w600),
          ),
        ),
        foregroundPainter: ArcProgressBarPainter(),
      ),
    );
  }
}
