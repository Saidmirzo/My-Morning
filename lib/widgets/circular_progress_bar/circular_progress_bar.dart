import 'package:flutter/material.dart';
import 'package:morningmagic/widgets/circular_progress_bar/circular_progress_bar_painter.dart';

class CircularProgressBar extends StatelessWidget {
  final Color backgroundColor;
  final Color foregroundColor;
  final double value;
  final String text;
  final double fontSize;

  const CircularProgressBar({
    Key key,
    @required this.text,
    @required this.backgroundColor,
    @required this.foregroundColor,
    @required this.value,
    @required this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final backgroundColor = this.backgroundColor;
    final foregroundColor = this.foregroundColor;
    return AspectRatio(
      aspectRatio: 1,
      child: CustomPaint(
        child: Container(
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: fontSize,
                color: foregroundColor,
              ),
            ),
          ),
        ),
        foregroundPainter: CircularProgressBarPainter(
          strokeWidth: 6,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          percentage: this.value,
        ),
      ),
    );
  }
}
