import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/pages/interview/interview1/components/multiline_input.dart';
import '../../interview1/interview_controller.dart';
import 'question_frame.dart';

Widget q6() {
  InterviewController _controller = Get.find();
  return QuestionFrame(
    index: 6,
    title: 'question_6'.tr,
    child: multilineInput(_controller.q6TextController, hint: 'start_input'.tr),
  );
}
