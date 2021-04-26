import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/pages/interview/components/multiline_input.dart';
import 'package:morningmagic/pages/interview/questions/question_frame.dart';

import '../interview_controller.dart';

Widget q10() {
  InterviewController _controller = Get.find();
  return QuestionFrame(
    index: 10,
    title: 'question_10'.tr,
    child: Obx(() => Column(
          children: <Widget>[
            ...List.generate(_controller.dollars.length, (i) {
              final _item = _controller.dollars[i];
              return SizedBox(
                height: 40,
                child: RadioListTile<int>(
                    title: Text(_item == -1 ? 'other'.tr : '$_item \$'),
                    value: _item,
                    contentPadding: EdgeInsets.zero,
                    groupValue: _controller.q10val.value,
                    onChanged: (int value) {
                      _controller.q10val.value = value;
                    }),
              );
            }),
            const SizedBox(height: 20),
            if (_controller.q10val.value == -1)
              multilineInput(_controller.q10TextControllerOther,
                  hint: 'start_input'.tr, minLines: 1),
          ],
        )),
  );
}
