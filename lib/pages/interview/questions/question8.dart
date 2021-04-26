import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/pages/interview/components/multiline_input.dart';
import 'package:morningmagic/pages/interview/questions/question_frame.dart';

import '../interview_controller.dart';

Widget q8() {
  InterviewController _controller = Get.find();
  return QuestionFrame(
    index: 8,
    title: 'question_8'.tr,
    child: multilineInput(_controller.q8TextController, hint: 'start_input'.tr),
  );
}
