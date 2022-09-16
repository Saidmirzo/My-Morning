import 'dart:math';
import 'package:flutter/material.dart';

class CircularContainer extends StatelessWidget {
  const CircularContainer({
    Key key,
    this.strokeWidth = 10,
    this.circularValue,
    this.text,
  }) : super(key: key);
  final double strokeWidth;
  final double circularValue;
  final String text;

  @override
  Widget build(BuildContext context) {
    double size = 120;

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            border: Border.all(width: strokeWidth, color: Colors.white),
            shape: BoxShape.circle
          ),
        ),
        SizedBox(
          width: size,
          height: size,
          child: CustomPaint(
            painter: ProgressPaint(
              progress: circularValue,
              width: strokeWidth,
              colors: [
                const Color(0xff592F72),
                const Color(0xffEEA6C8),
              ],
            ),
          ),
        ),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w700,
            fontFamily: 'Montserrat',
          ),
        ),
      ],
    );
  }
}

class ProgressPaint extends CustomPainter {
  ProgressPaint({
    this.progress,
    this.colors,
    this.width,
    this.stops,
  });
  final double progress;
  final List<Color> colors;
  final double width;
  final List<double> stops;
  @override
  void paint(Canvas canvas, Size size) {
    var rect = Rect.fromLTWH(0.0, 0.0, size.width - 20, size.height - 20);
    var gradient = LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: colors,
    );
    var paint = Paint()
      ..shader = gradient.createShader(rect)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..color = const Color(0xffC394EC)
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.solid,
        10,
      )
      ..strokeWidth = width;

    var center = Offset(size.width / 2, size.height / 2);
    var radius = min(size.width / 2, size.height / 2) - (width / 2);
    var startAngle = -pi / 2;
    var sweepAngle = 2 * pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
