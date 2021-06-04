import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/resources/colors.dart';

class AppGradientContainer extends StatelessWidget {
  final Widget child;
  final Gradient gradient;

  const AppGradientContainer({Key key, @required this.child, this.gradient})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      decoration: BoxDecoration(gradient: gradient ?? AppColors.Bg_Gradient_1),
      child: child,
    );
  }
}
