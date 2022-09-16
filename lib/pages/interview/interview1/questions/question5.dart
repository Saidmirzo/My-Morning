import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/pages/interview/interview1/components/multiline_input.dart';
import '../../interview1/interview_controller.dart';
import '../components/multiline_input.dart';
import 'question_frame.dart';

Widget q5() {
  InterviewController _controller = Get.find();
  return QuestionFrame(
    index: 5,
    title: 'question_5'.tr,
    child: multilineInput(_controller.q5TextController, hint: 'start_input'.tr),
  );
}
