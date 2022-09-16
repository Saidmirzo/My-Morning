import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/multiline_input.dart';
import 'question_frame.dart';
import '../interview_controller.dart';

Widget qOneField(String title, int index) {
  TextEditingController fieldController = TextEditingController();
  Interview2Controller _controller = Get.find();
  return QuestionFrame(
    index: index,
    title: title,
    child: multilineInput(fieldController, hint: 'start_input'.tr),
    onNext: () {
      if (fieldController.text.isEmpty) {
        Get.snackbar(null, 'please_fill_all_fields'.tr);
      } else {
        _controller.data[title] = fieldController.text;
        _controller.slideNext();
      }
    },
  );
}
