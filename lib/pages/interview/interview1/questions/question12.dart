import 'package:flutter/material.dart';
import '../components/multiline_input.dart';
import '../components/title_question.dart';
import '../questions/question_frame.dart';
import 'package:get/get.dart';
import '../../interview1/interview_controller.dart';

Widget q12() {
  InterviewController _controller = Get.find();
  return QuestionFrame(
    index: 12,
    title: 'question_12'.tr,
    child: Obx(() => Column(
          children: <Widget>[
            SizedBox(
              height: 40,
              child: RadioListTile<YesNoOther>(
                title: Text('yes'.tr),
                value: YesNoOther.yes,
                groupValue: _controller.q12val.value,
                onChanged: (YesNoOther value) {
                  _controller.q12val.value = value;
                },
              ),
            ),
            SizedBox(
              height: 40,
              child: RadioListTile<YesNoOther>(
                title: Text('no'.tr),
                value: YesNoOther.no,
                groupValue: _controller.q12val.value,
                onChanged: (YesNoOther value) {
                  _controller.q12val.value = value;
                },
              ),
            ),
            SizedBox(
              height: 40,
              child: RadioListTile<YesNoOther>(
                title: Text('other'.tr),
                value: YesNoOther.other,
                groupValue: _controller.q12val.value,
                onChanged: (YesNoOther value) {
                  _controller.q12val.value = value;
                },
              ),
            ),
            const SizedBox(height: 20),
            if (_controller.q12val.value == YesNoOther.other)
              multilineInput(_controller.q12TextController,
                  hint: 'start_input'.tr),
            if (_controller.q12val.value == YesNoOther.yes) ...[
              titleQuestion('question_12_subquestion_1'.tr),
              const SizedBox(height: 20),
              multilineInput(_controller.q12TextController2,
                  hint: 'start_input'.tr),
            ],
          ],
        )),
  );
}
