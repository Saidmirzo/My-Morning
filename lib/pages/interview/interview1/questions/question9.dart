import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/pages/interview/interview1/components/multiline_input.dart';

import '../../interview1/interview_controller.dart';
import '../components/multiline_input.dart';
import 'question_frame.dart';

Widget q9() {
  InterviewController _controller = Get.find();
  return QuestionFrame(
    index: 9,
    title: 'question_9'.tr,
    child: Obx(() => Column(
          children: [
            ...List.generate(_controller.q9Futures.value.length, (index) {
              final _item = _controller.q9Futures.value[index];
              return SizedBox(
                height: 40,
                child: CheckboxListTile(
                  value: _item.isActive,
                  title: Text(_item.name),
                  onChanged: (_val) {
                    _item.isActive = _val;
                    _controller.q9Futures.refresh();
                  },
                ),
              );
            }),
            const SizedBox(height: 20),
            if (_controller.q9Futures.value
                .firstWhere((element) => element.name == 'other'.tr)
                .isActive)
              multilineInput(_controller.q9TextController,
                  hint: 'start_input'.tr),
          ],
        )),
  );
}
