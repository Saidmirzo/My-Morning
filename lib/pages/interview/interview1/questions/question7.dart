import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/pages/interview/interview1/components/multiline_input.dart';

import '../../interview1/interview_controller.dart';
import 'question_frame.dart';

Widget q7() {
  InterviewController _controller = Get.find();
  return QuestionFrame(
    index: 7,
    title: 'question_7'.tr,
    child: Obx(() => Column(
          children: <Widget>[
            SizedBox(
              height: 40,
              child: RadioListTile<YesNoOther>(
                title: Text('yes'.tr),
                value: YesNoOther.yes,
                groupValue: _controller.q7val.value,
                onChanged: (YesNoOther value) {
                  _controller.q7val.value = value;
                },
              ),
            ),
            SizedBox(
              height: 40,
              child: RadioListTile<YesNoOther>(
                title: Text('no'.tr),
                value: YesNoOther.no,
                groupValue: _controller.q7val.value,
                onChanged: (YesNoOther value) {
                  _controller.q7val.value = value;
                },
              ),
            ),
            SizedBox(
              height: 40,
              child: RadioListTile<YesNoOther>(
                title: Text('other'.tr),
                value: YesNoOther.other,
                groupValue: _controller.q7val.value,
                onChanged: (YesNoOther value) {
                  _controller.q7val.value = value;
                },
              ),
            ),
            const SizedBox(height: 20),
            if (_controller.q7val.value == YesNoOther.other)
              multilineInput(_controller.q7TextController,
                  hint: 'start_input'.tr),
          ],
        )),
  );
}
