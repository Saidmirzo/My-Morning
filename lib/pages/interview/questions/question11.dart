import 'package:flutter/material.dart';
import 'package:morningmagic/pages/interview/components/multiline_input.dart';
import 'package:morningmagic/pages/interview/questions/question_frame.dart';
import 'package:get/get.dart';

import '../interview_controller.dart';

Widget q11() {
  InterviewController _controller = Get.find();
  return QuestionFrame(
    index: 11,
    title: 'question_11'.tr,
    child: multilineInput(_controller.q11Controller, hint: 'start_input'.tr),
  );
}
