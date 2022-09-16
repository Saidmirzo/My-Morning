import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../interview_controller.dart';

Widget dotPanel(int _count) {
  InterviewController _controller = Get.find();
  return Obx(() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(_count, (index) {
          final isActive = index <= _controller.currQuestion.value;
          const size = 13.0;
          return Container(
            width: size - 1,
            height: size - 1,
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: isActive ? Colors.white : Colors.white.withOpacity(.4)),
          );
        }),
      ));
}
