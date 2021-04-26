import 'package:flutter/material.dart';
import 'package:morningmagic/pages/interview/components/multiline_input.dart';
import 'package:morningmagic/pages/interview/questions/question_frame.dart';
import 'package:get/get.dart';

import '../interview_controller.dart';

Widget q6() {
  InterviewController _controller = Get.find();
  return QuestionFrame(
    index: 6,
    title: 'question_6'.tr,
    child: multilineInput(_controller.q6TextController, hint: 'start_input'.tr),
  );
}
