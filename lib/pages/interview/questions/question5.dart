import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/pages/interview/questions/question_frame.dart';

import '../interview_controller.dart';

Widget q5() {
  InterviewController _controller = Get.find();
  return QuestionFrame(
    index: 5,
    title: 'question_5'.tr,
    child: Obx(() => Column(
          children: List.generate(_controller.q5Futures.value.length, (index) {
            final _item = _controller.q5Futures.value[index];
            return SizedBox(
              height: 40,
              child: CheckboxListTile(
                value: _item.isActive,
                title: Text(_item.name),
                onChanged: (_val) {
                  _item.isActive = _val;
                  _controller.q5Futures.refresh();
                },
              ),
            );
          }),
        )),
  );
}
