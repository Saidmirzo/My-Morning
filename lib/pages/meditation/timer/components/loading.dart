import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/styled_text.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/storage.dart';

Widget buildAudioLoading() {
  return SizedBox(
    height: 92,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StyledText('audio_loading'.tr,
            fontSize: 16,
            color: menuState == MenuState.MORNING
                ? AppColors.violet
                : Colors.white),
        const SizedBox(width: 16),
        CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
              menuState == MenuState.MORNING ? AppColors.violet : Colors.white),
        ),
      ],
    ),
  );
}
