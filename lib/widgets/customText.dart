import 'package:flutter/material.dart';
import 'package:morningmagic/resources/colors.dart';

class AffirmationText extends StatelessWidget {
  final String text;
  final double size;


  AffirmationText({
    @required this.text,
    @required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.WHITE,
          fontStyle: FontStyle.normal,
          fontFamily: 'rex',
          fontSize: size,
        ),
      ),
    );
  }
}