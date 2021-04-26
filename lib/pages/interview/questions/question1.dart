import 'package:flutter/material.dart';
import 'package:morningmagic/pages/interview/components/multiline_input.dart';
import 'package:morningmagic/pages/interview/questions/question_frame.dart';
import 'package:get/get.dart';

import '../interview_controller.dart';

Widget q1() {
  InterviewController _controller = Get.find();
  return QuestionFrame(
    index: 1,
    title: 'question_1'.tr,
    child: multilineInput(_controller.q1Controller, hint: 'start_input'.tr),
  );
}
