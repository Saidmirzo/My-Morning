import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:morningmagic/pages/reminders/models/reminder.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/widgets/primary_circle_button.dart';

import 'reminder_controller.dart';

class RemindersPage extends StatefulWidget {
  @override
  _RemindersPageState createState() => _RemindersPageState();
}

class _RemindersPageState extends State<RemindersPage> {
  ReminderController _controller = Get.put(ReminderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        decoration: BoxDecoration(gradient: AppColors.gradient_settings_page),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: Get.height * 0.92,
              width: Get.width,
              child: Column(
                children: [
                  Row(
                    children: [
                      PrimaryCircleButton(
                        onPressed: () => Get.back(),
                        icon: Icon(Icons.arrow_back, color: Colors.black54),
                        bgColor: Colors.black12,
                      ),
                      Text(
                        'reminders'.tr,
                        style: TextStyle(fontSize: Get.height * 0.036),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Obx(
                      () {
                        int lngh = _controller.reminders.value.length;
                        return lngh > 0
                            ? ListView.builder(
                                shrinkWrap: true,
                                itemCount: lngh,
                                itemBuilder: (_, i) {
                                  return reminder(
                                      _controller.reminders.value[i]);
                                },
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'add_first_reminder'.tr,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: Get.height * 0.025,
                                      color: Colors.black.withOpacity(.5),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 30),
                                  Image.asset(
                                    'assets/images/arrow_bottom.png',
                                    color: Colors.black.withOpacity(.6),
                                  ),
                                  SizedBox(height: 30),
                                ],
                              );
                      },
                    ),
                  ),
                  PrimaryCircleButton(
                    onPressed: () {
                      _controller.addReminder();
                    },
                    icon: Icon(Icons.add, color: Colors.black54),
                    bgColor: Colors.black12,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget reminder(ReminderModel _reminder) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color:
            _reminder.isActive ? AppColors.TRANSPARENT_WHITE : Colors.black12,
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                children: [
                  Text(
                    DateFormat('HH:mm').format(_reminder.date).toString(),
                    style: TextStyle(
                        fontSize: Get.height * 0.03,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              Spacer(),
              Switch(
                value: _reminder.isActive ?? false,
                onChanged: (value) {
                  _controller.setActive(_reminder, value);
                },
                activeColor: AppColors.PINK,
                inactiveThumbColor: Colors.black.withOpacity(.7),
              ),
              CupertinoButton(
                  child: Icon(Icons.delete, color: Colors.black54),
                  onPressed: () => _controller.removeReminder(_reminder)),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            _reminder.text ?? 'reminders'.tr,
            style: TextStyle(
                fontSize: Get.height * 0.017, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              dayText('monday_short'.tr,
                  isActive: _reminder.activeDays.contains(1)),
              dayText('tuesday_short'.tr,
                  isActive: _reminder.activeDays.contains(2)),
              dayText('wednesday_short'.tr,
                  isActive: _reminder.activeDays.contains(3)),
              dayText('thursday_short'.tr,
                  isActive: _reminder.activeDays.contains(4)),
              dayText('friday_short'.tr,
                  isActive: _reminder.activeDays.contains(5)),
              dayText('saturday_short'.tr,
                  isActive: _reminder.activeDays.contains(6)),
              dayText('sunday_short'.tr,
                  isActive: _reminder.activeDays.contains(7)),
            ],
          ),
        ],
      ),
    );
  }

  Widget dayText(String item, {bool isActive = false}) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Text(item,
          style: TextStyle(
              fontSize: Get.height * 0.017,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
              color: Colors.black.withOpacity(isActive ? 1 : 0.35))),
    );
  }
}
