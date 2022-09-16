import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/pages/interview/interview1/components/multiline_input.dart';
import 'package:morningmagic/pages/interview/interview1/components/title_question.dart';
import '../../interview1/interview_controller.dart';
import 'question_frame.dart';

Widget q11() {
  InterviewController _controller = Get.find();
  return QuestionFrame(
    index: 11,
    title: 'question_11'.tr,
    child: Obx(() => Column(
          children: <Widget>[
            SizedBox(
              height: 40,
              child: RadioListTile<YesNoOther>(
                title: Text('yes'.tr),
                value: YesNoOther.yes,
                groupValue: _controller.q11val.value,
                onChanged: (YesNoOther value) {
                  _controller.q11val.value = value;
                },
              ),
            ),
            SizedBox(
              height: 40,
              child: RadioListTile<YesNoOther>(
                title: Text('no'.tr),
                value: YesNoOther.no,
                groupValue: _controller.q11val.value,
                onChanged: (YesNoOther value) {
                  _controller.q11val.value = value;
                },
              ),
            ),
            SizedBox(
              height: 40,
              child: RadioListTile<YesNoOther>(
                title: Text('other'.tr),
                value: YesNoOther.other,
                groupValue: _controller.q11val.value,
                onChanged: (YesNoOther value) {
                  _controller.q11val.value = value;
                },
              ),
            ),
            const SizedBox(height: 20),
            if (_controller.q11val.value == YesNoOther.other)
              multilineInput(_controller.q11TextController,
                  hint: 'start_input'.tr),
            if (_controller.q11val.value == YesNoOther.yes) ...[
              titleQuestion('question_11_subquestion_1'.tr),
              const SizedBox(height: 20),
              multilineInput(_controller.q11TextController2,
                  hint: 'start_input'.tr),
            ],
          ],
        )),
  );
}
