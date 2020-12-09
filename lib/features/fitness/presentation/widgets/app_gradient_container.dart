import 'package:flutter/material.dart';
import 'package:morningmagic/resources/colors.dart';

class AppGradientContainer extends StatelessWidget {
  final Widget child;

  const AppGradientContainer({Key key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          AppColors.TOP_GRADIENT,
          AppColors.MIDDLE_GRADIENT,
          AppColors.BOTTOM_GRADIENT
        ],
      )),
      child: child,
    );
  }
}
