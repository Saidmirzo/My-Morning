import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/pages/interview/interview2/models/futures.dart';
import '../components/multiline_input.dart';
import '../interview_controller.dart';
import 'question_frame.dart';

Widget qFutures(String title, int index) {
  var futuresList = RxList<Futures>().obs;
  TextEditingController fieldController = TextEditingController();
  futuresList.value = [
    Futures(name: 'meditation_small'.tr),
    Futures(name: 'affirmation_small'.tr),
    Futures(name: 'visualization_small'.tr),
    Futures(name: 'fitness_small'.tr),
    Futures(name: 'reading_small'.tr),
    Futures(name: 'diary_small'.tr),
    Futures(name: 'other'.tr),
  ].obs;
  Interview2Controller _controller = Get.find();
  return QuestionFrame(
    index: index,
    title: title,
    onNext: () {
      List<String> _items = [];
      for (var element in futuresList.value) {
        if (element.isActive) {
          element.name == 'other'.tr
              ? _items.add(fieldController.text)
              : _items.add(element.name);
        }
      }
      if (_items.isEmpty) return;
      _controller.data[title] = _items;
      _controller.slideNext();
    },
    child: Obx(() => Column(
          children: [
            ...List.generate(futuresList.value.length, (index) {
              final _item = futuresList.value[index];
              return SizedBox(
                height: 40,
                child: CheckboxListTile(
                  value: _item.isActive,
                  title: Text(_item.name),
                  onChanged: (_val) {
                    _item.isActive = _val;
                    futuresList.refresh();
                  },
                ),
              );
            }),
            const SizedBox(height: 20),
            if (futuresList.value
                .firstWhere((element) => element.name == 'other'.tr)
                .isActive)
              multilineInput(fieldController, hint: 'start_input'.tr),
          ],
        )),
  );
}
