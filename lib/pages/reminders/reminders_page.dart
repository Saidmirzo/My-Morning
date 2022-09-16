import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:morningmagic/pages/reminders/models/reminder.dart';
import 'reminder_controller.dart';

class RemindersPage extends StatefulWidget {
  @override
  _RemindersPageState createState() => _RemindersPageState();
}

class _RemindersPageState extends State<RemindersPage> {
  final ReminderController _controller = Get.put(ReminderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/reminder_page_bg.png'),
              fit: BoxFit.fill),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(31, 30, 31, 27),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: const Icon(
                        Icons.west,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'reminders'.tr,
                      style: TextStyle(
                          fontSize: Get.height * 0.036, color: Colors.white),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Obx(
                  () {
                    int lngh = _controller.reminders.value.length;
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: lngh,
                      itemBuilder: (_, i) {
                        return ReminderItem(
                          controller: _controller,
                          reminder: _controller.reminders.value[i],
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  _controller.addReminder();
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.maxFinite,
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  margin: const EdgeInsets.symmetric(horizontal: 31),
                  decoration: BoxDecoration(
                    color: const Color(0xff592F72),
                    borderRadius: BorderRadius.circular(19),
                  ),
                  child: Text(
                    'Add a reminder'.tr,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 43,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReminderItem extends StatefulWidget {
  const ReminderItem({Key key, this.reminder, this.controller})
      : super(key: key);
  final ReminderModel reminder;
  final ReminderController controller;
  @override
  State<ReminderItem> createState() => _ReminderItemState();
}

class _ReminderItemState extends State<ReminderItem> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white.withOpacity(0.4)),
          margin: const EdgeInsets.fromLTRB(
            31,
            0,
            31,
            12,
          ),
          padding: const EdgeInsets.fromLTRB(25, 25, 25, 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      Text(
                        DateFormat('HH:mm')
                            .format(widget.reminder.date)
                            .toString(),
                        style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      widget.controller.setActive(widget.reminder,
                          !(widget.reminder.isActive ?? false));
                    },
                    child: Stack(
                      children: [
                        Container(
                          width: 29.39,
                          height: 18.32,
                          decoration: BoxDecoration(
                            color: widget.reminder.isActive ?? false
                                ? const Color(0xff592F72)
                                : const Color(0xff592F72).withOpacity(.4),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        Positioned(
                          right:
                              widget.reminder.isActive ?? false ? 4.16 : 15.23,
                          left:
                              !widget.reminder.isActive ?? false ? 4.16 : 15.23,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 4.16),
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: widget.reminder.isActive ?? false
                                  ? Colors.white.withOpacity(.9)
                                  : Colors.white.withOpacity(.4),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 9.72,
                  ),
                  GestureDetector(
                    onTap: () =>
                        widget.controller.removeReminder(widget.reminder),
                    child: Container(
                      width: 31.29,
                      height: 31.29,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9.4),
                        color: const Color(0xffFF0000).withOpacity(0.08),
                      ),
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/images/fitnes/delete_icon.png',
                        width: 10.51,
                        height: 13.56,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                widget.reminder.text ?? 'reminders'.tr,
                style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  dayText(
                    'monday_short'.tr,
                    isActive: widget.reminder.activeDays.contains(1),
                  ),
                  dayText(
                    'tuesday_short'.tr,
                    isActive: widget.reminder.activeDays.contains(2),
                  ),
                  dayText(
                    'wednesday_short'.tr,
                    isActive: widget.reminder.activeDays.contains(3),
                  ),
                  dayText(
                    'thursday_short'.tr,
                    isActive: widget.reminder.activeDays.contains(4),
                  ),
                  dayText(
                    'friday_short'.tr,
                    isActive: widget.reminder.activeDays.contains(5),
                  ),
                  dayText(
                    'saturday_short'.tr,
                    isActive: widget.reminder.activeDays.contains(6),
                  ),
                  dayText(
                    'sunday_short'.tr,
                    isActive: widget.reminder.activeDays.contains(7),
                  ),
                ],
              ),
            ],
          ),
        ),
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
              color: Colors.white.withOpacity(isActive ? 1 : 0.8))),
    );
  }
}
