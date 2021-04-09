import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/resources/colors.dart';

class AppGradientContainer extends StatelessWidget {
  final Widget child;

  const AppGradientContainer({Key key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      decoration: BoxDecoration(gradient: AppColors.Bg_Gradient_1),
      child: child,
    );
  }
}
