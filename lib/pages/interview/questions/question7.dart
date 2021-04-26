import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/pages/interview/components/multiline_input.dart';
import 'package:morningmagic/pages/interview/questions/question_frame.dart';

import '../interview_controller.dart';

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
