import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:morningmagic/pages/interview/interview1/components/multiline_input.dart';
import 'question_frame.dart';

import '../../interview1/interview_controller.dart';

Widget q1() {
  InterviewController _controller = Get.find();
  return QuestionFrame(
    index: 1,
    title: 'question_1'.tr,
    child: multilineInput(_controller.q1Controller, hint: 'start_input'.tr),
  );
}
