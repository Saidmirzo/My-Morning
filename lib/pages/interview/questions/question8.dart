import 'package:flutter/material.dart';
import 'package:morningmagic/pages/interview/components/multiline_input.dart';
import 'package:morningmagic/pages/interview/components/title_question.dart';
import 'package:morningmagic/pages/interview/questions/question_frame.dart';
import 'package:get/get.dart';

import '../interview_controller.dart';

Widget q8() {
  InterviewController _controller = Get.find();
  return QuestionFrame(
    index: 8,
    title: 'question_8'.tr,
    child: Obx(() => Column(
          children: <Widget>[
            SizedBox(
              height: 40,
              child: RadioListTile<YesNoOther>(
                title: Text('yes'.tr),
                value: YesNoOther.yes,
                groupValue: _controller.q8val.value,
                onChanged: (YesNoOther value) {
                  _controller.q8val.value = value;
                },
              ),
            ),
            SizedBox(
              height: 40,
              child: RadioListTile<YesNoOther>(
                title: Text('no'.tr),
                value: YesNoOther.no,
                groupValue: _controller.q8val.value,
                onChanged: (YesNoOther value) {
                  _controller.q8val.value = value;
                },
              ),
            ),
            SizedBox(
              height: 40,
              child: RadioListTile<YesNoOther>(
                title: Text('other'.tr),
                value: YesNoOther.other,
                groupValue: _controller.q8val.value,
                onChanged: (YesNoOther value) {
                  _controller.q8val.value = value;
                },
              ),
            ),
            const SizedBox(height: 20),
            if (_controller.q8val.value == YesNoOther.other)
              multilineInput(_controller.q8TextController,
                  hint: 'start_input'.tr),
            if (_controller.q8val.value == YesNoOther.yes) ...[
              titleQuestion('question_8_subquestion_1'.tr),
              const SizedBox(height: 20),
              multilineInput(_controller.q8TextController2,
                  hint: 'start_input'.tr),
            ],
          ],
        )),
  );
}
