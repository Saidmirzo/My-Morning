import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/widgets/primary_circle_button.dart';

class BackComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: PrimaryCircleButton(
        icon: Icon(Icons.arrow_back, color: AppColors.primary),
        onPressed: () => Get.back(),
        size: 40,
      ),
    );
  }
}
