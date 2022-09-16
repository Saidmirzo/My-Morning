import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/utils/other.dart';
import 'question_frame.dart';

Widget thanksScreen() {
  return QuestionFrame(
    index: 9,
    title: 'thanks_to_interview'.tr,
    child: const SizedBox(),
    onNext: () {
      openUrl(Platform.isIOS
          ? 'https://support.apple.com/ru-ru/HT202039'
          : 'https://support.google.com/googleplay/answer/7018481?co=GENIE.Platform%3DAndroid&hl=ru');
      Get.back();
    },
  );
}
