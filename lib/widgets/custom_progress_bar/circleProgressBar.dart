import 'package:flutter/material.dart';
import '../../resources/colors.dart';
import '../custom_progress_bar/circleProgressBarPainter.dart';

class CircleProgressBar extends StatelessWidget {
  final Color foregroundColor;
  final double value;
  final String text;
  final double textSize;


  const CircleProgressBar({
    Key key,
    @required this.foregroundColor,
    @required this.value,
    @required this.text, this.textSize = 55,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final foregroundColor = this.foregroundColor;
    return AspectRatio(
      aspectRatio: 1,
      child: CustomPaint(
        child: Center(
          child: Text(
            text,
              style: TextStyle(
                fontSize: textSize,
                fontFamily: "aparaj",
                fontStyle: FontStyle.normal,
                color: AppColors.VIOLET,
              ),
          ),
        ),
        foregroundPainter: CircleProgressBarPainter(
          foregroundColor: foregroundColor,
          percentage: this.value,
        ),
      ),
    );
  }
}