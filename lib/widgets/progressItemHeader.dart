import 'package:flutter/material.dart';
import 'package:morningmagic/resources/colors.dart';

class ProgressItemHeader extends StatelessWidget {
  final String title;


  const ProgressItemHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      maxLines: 1,
      style: const TextStyle(
        fontSize: 22,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.bold,
        color: AppColors.violet,
      ),
    );
  }
}