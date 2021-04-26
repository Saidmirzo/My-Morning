import 'package:flutter/material.dart';
import 'package:morningmagic/pages/interview/components/multiline_input.dart';
import 'package:morningmagic/pages/interview/questions/question_frame.dart';
import 'package:get/get.dart';

import '../interview_controller.dart';

Widget q10() {
  InterviewController _controller = Get.find();
  return QuestionFrame(
    index: 10,
    title: 'question_10'.tr,
    child:
        multilineInput(_controller.q10TextController, hint: 'start_input'.tr),
  );
}
