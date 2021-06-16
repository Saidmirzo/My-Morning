import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/pages/interview/interview2/components/multiline_input.dart';

import '../interview_controller.dart';
import 'question_frame.dart';

Widget qYesNoOther(String title, int index) {
  Interview2Controller _controller = Get.find();
  Rx<YesNoOther> val = YesNoOther.nan.obs;
  TextEditingController fieldController = TextEditingController();
  return QuestionFrame(
    index: index,
    title: title,
    onNext: () {
      if (val.value == YesNoOther.nan ||
          (val.value == YesNoOther.other && fieldController.text.isEmpty)) {
        Get.snackbar(null, 'please_fill_all_fields'.tr);
      } else {
        if (val.value == YesNoOther.other)
          _controller.data[title] = fieldController.text;
        if (val.value == YesNoOther.yes)
          _controller.data[title] = 'да';
        else
          _controller.data[title] = 'нет';
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
          ],
        )),
  );
}
