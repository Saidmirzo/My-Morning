import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'colors.dart';

class AppStyles {
  static const TextStyle btnTextStyle =
      TextStyle(color: AppColors.btnText, fontWeight: FontWeight.w700);
  static final TextStyle trainingTitle = TextStyle(
    fontSize: Get.height * 0.03,
    color: AppColors.white,
    fontWeight: FontWeight.w600,
  );
  static final TextStyle trainingSubtitle = TextStyle(
    fontSize: Get.height * 0.020,
    color: AppColors.white,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle instrumentCategoryText = TextStyle(
    fontSize: Get.height * 0.020,
    color: AppColors.instrumentTextColor,
    fontWeight: FontWeight.w500,
  );
}
