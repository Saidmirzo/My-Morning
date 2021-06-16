import 'package:flutter/material.dart';
import 'package:morningmagic/pages/interview/interview1/components/multiline_input.dart';
import 'package:morningmagic/pages/interview/interview1/components/title_question.dart';
import 'question_frame.dart';
import 'package:get/get.dart';

import '../../interview1/interview_controller.dart';

Widget q3() {
  InterviewController _controller = Get.find();
  return QuestionFrame(
    index: 3,
    title: 'question_3'.tr,
    child: Obx(() => Column(
          children: <Widget>[
            SizedBox(
              height: 40,
              child: RadioListTile<YesNoOther>(
                title: Text('yes'.tr),
                value: YesNoOther.yes,
                groupValue: _controller.q3val.value,
                onChanged: (YesNoOther value) {
                  _controller.q3val.value = value;
                },
              ),
            ),
            SizedBox(
              height: 40,
              child: RadioListTile<YesNoOther>(
                title: Text('no'.tr),
                value: YesNoOther.no,
                groupValue: _controller.q3val.value,
                onChanged: (YesNoOther value) {
                  _controller.q3val.value = value;
                },
              ),
            ),
            SizedBox(
              height: 40,
              child: RadioListTile<YesNoOther>(
                title: Text('other'.tr),
                value: YesNoOther.other,
                groupValue: _controller.q3val.value,
                onChanged: (YesNoOther value) {
                  _controller.q3val.value = value;
                },
              ),
            ),
            const SizedBox(height: 20),
            if (_controller.q3val.value == YesNoOther.other)
              multilineInput(_controller.q3TextController,
                  hint: 'start_input'.tr),
            if (_controller.q3val.value == YesNoOther.yes) ...[
              titleQuestion('question_3_subquestion_1'.tr),
              const SizedBox(height: 20),
              multilineInput(_controller.q3TextController2,
                  hint: 'start_input'.tr),
            ],
          ],
        )),
  );
}
