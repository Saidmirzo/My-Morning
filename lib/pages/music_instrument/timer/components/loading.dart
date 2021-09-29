import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/styled_text.dart';
import 'package:morningmagic/resources/colors.dart';

Widget buildAudioLoading() {
  return Container(
      height: 92,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StyledText('audio_loading'.tr, fontSize: 16),
          SizedBox(width: 16),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.VIOLET),
          ),
        ],
      ));
}
