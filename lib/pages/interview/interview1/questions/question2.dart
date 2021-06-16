import 'package:flutter/material.dart';
import 'package:morningmagic/pages/interview/interview1/components/multiline_input.dart';
import 'package:morningmagic/pages/interview/interview1/components/title_question.dart';
import 'question_frame.dart';
import 'package:get/get.dart';

import '../../interview1/interview_controller.dart';

Widget q2() {
  InterviewController _controller = Get.find();
  return QuestionFrame(
    index: 2,
    title: 'question_2'.tr,
    child: Obx(() => Column(
          children: <Widget>[
            SizedBox(
              height: 40,
              child: RadioListTile<YesNoOther>(
                title: Text('yes'.tr),
                value: YesNoOther.yes,
                groupValue: _controller.q2val.value,
                onChanged: (YesNoOther value) {
                  _controller.q2val.value = value;
                },
              ),
            ),
            SizedBox(
              height: 40,
              child: RadioListTile<YesNoOther>(
                title: Text('no'.tr),
                value: YesNoOther.no,
                groupValue: _controller.q2val.value,
                onChanged: (YesNoOther value) {
                  _controller.q2val.value = value;
                },
              ),
            ),
            const SizedBox(height: 20),
            if (_controller.q2val.value == YesNoOther.yes) ...[
              titleQuestion('question_2_subquestion_1'.tr),
              const SizedBox(height: 20),
              multilineInput(_controller.q2TextController,
                  hint: 'start_input'.tr),
            ]
          ],
        )),
  );
}
