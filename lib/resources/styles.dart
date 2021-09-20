import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'colors.dart';

class AppStyles {
  static final TextStyle btnTextStyle =
      TextStyle(color: AppColors.btnText, fontWeight: FontWeight.w700);
  static final TextStyle treaningTitle = TextStyle(
    fontSize: Get.height * 0.03,
    color: AppColors.WHITE,
    fontWeight: FontWeight.w600,
  );
  static final TextStyle treaningSubtitle = TextStyle(
    fontSize: Get.height * 0.020,
    color: AppColors.WHITE,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle instrumentCategotyText = TextStyle(
    fontSize: Get.height * 0.020,
    color: AppColors.instrument_text_color,
    fontWeight: FontWeight.w500,
  );
}
