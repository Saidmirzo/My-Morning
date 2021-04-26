import 'package:flutter/material.dart';
import 'package:morningmagic/pages/interview/components/multiline_input.dart';
import 'package:morningmagic/pages/interview/questions/question_frame.dart';
import 'package:get/get.dart';

import '../interview_controller.dart';

Widget q13() {
  InterviewController _controller = Get.find();
  return QuestionFrame(
    index: 13,
    title: 'question_13'.tr,
    child: multilineInput(_controller.q13Controller, hint: 'start_input'.tr),
  );
}
