import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/resources/colors.dart';

import '../reminder_controller.dart';

class AddTimeDialog extends StatelessWidget {
  ReminderController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          createInlinePicker(
            context: Get.context,
            value: TimeOfDay.now(),
            onChange: (TimeOfDay _time) {
              _controller.selectedTime = _time;
              Get.back();
            },
            is24HrFormat: true,
          ),
          Text('select_week_day'.tr,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: Get.height * 0.019,
                  fontWeight: FontWeight.w500)),
          const SizedBox(height: 20),
          Container(
            width: Get.width * .8,
            child: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  dayBtn(
                    'monday_short'.tr,
                    1,
                  ),
                  dayBtn('tuesday_short'.tr, 2),
                  dayBtn('wednesday_short'.tr, 3),
                  dayBtn('thursday_short'.tr, 4),
                  dayBtn('friday_short'.tr, 5),
                  dayBtn('saturday_short'.tr, 6),
                  dayBtn('sunday_short'.tr, 7),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget dayBtn(String item, int index) {
    bool isActive = _controller.activeDays.value.contains(index);
    return GestureDetector(
      onTap: () {
        isActive
            ? _controller.activeDays.value.remove(index)
            : _controller.activeDays.value.add(index);
      },
      child: Container(
        margin: const EdgeInsets.all(1),
        padding: const EdgeInsets.all(5),
        height: 80,
        width: (Get.width / 7) * .7,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isActive ? Colors.blueAccent : Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(item,
            style: TextStyle(
                fontSize: Get.height * 0.017,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                color: Colors.black)),
      ),
    );
  }
}
