import 'package:flutter/material.dart';
import 'package:morningmagic/pages/interview/interview1/components/multiline_input.dart';
import 'package:morningmagic/pages/interview/interview1/components/title_question.dart';
import '../interview_controller.dart';
import 'question_frame.dart';
import 'package:get/get.dart';

Widget qYesNoOtherIfyes(String title, String subtitle, int index) {
  Interview2Controller _controller = Get.find();
  Rx<YesNoOther> val = YesNoOther.nan.obs;
  TextEditingController fieldController = TextEditingController();
  TextEditingController fieldController2 = TextEditingController();
  return QuestionFrame(
    index: index,
    title: title,
    onNext: () {
      if (val.value == YesNoOther.nan ||
          (val.value == YesNoOther.other && fieldController.text.isEmpty) ||
          (val.value == YesNoOther.yes && fieldController2.text.isEmpty)) {
        Get.snackbar(null, 'please_fill_all_fields'.tr);
      } else {
        if (val.value == YesNoOther.yes)
          _controller.data[title + ' ' + 'если да'] = fieldController2.text;
        if (val.value == YesNoOther.no) _controller.data[title] = 'нет';
        if (val.value == YesNoOther.other)
          _controller.data[title.tr + ' ' + 'если другое'] =
              fieldController.text;
        _controller.slideNext();
      }
    },
    child: Obx(() => Column(
          children: <Widget>[
            SizedBox(
              height: 40,
              child: RadioListTile<YesNoOther>(
                title: Text('yes'.tr),
                value: YesNoOther.yes,
                groupValue: val.value,
                onChanged: (YesNoOther value) {
                  val.value = value;
                },
              ),
            ),
            SizedBox(
              height: 40,
              child: RadioListTile<YesNoOther>(
                title: Text('no'.tr),
                value: YesNoOther.no,
                groupValue: val.value,
                onChanged: (YesNoOther value) {
                  val.value = value;
                },
              ),
            ),
            SizedBox(
              height: 40,
              child: RadioListTile<YesNoOther>(
                title: Text('other'.tr),
                value: YesNoOther.other,
                groupValue: val.value,
                onChanged: (YesNoOther value) {
                  val.value = value;
                },
              ),
            ),
            const SizedBox(height: 20),
            if (val.value == YesNoOther.other)
              multilineInput(fieldController, hint: 'start_input'.tr),
            if (val.value == YesNoOther.yes) ...[
              titleQuestion(subtitle),
              multilineInput(fieldController2, hint: 'start_input'.tr),
            ]
          ],
        )),
  );
}
