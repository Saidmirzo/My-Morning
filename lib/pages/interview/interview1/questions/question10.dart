import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/pages/interview/interview1/components/multiline_input.dart';

import '../../interview1/interview_controller.dart';
import 'question_frame.dart';

Widget q10() {
  InterviewController _controller = Get.find();
  return QuestionFrame(
    index: 10,
    title: 'question_10'.tr,
    child:
        multilineInput(_controller.q10TextController, hint: 'start_input'.tr),
  );
}
