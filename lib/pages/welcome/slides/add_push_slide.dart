import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/pages/reminders/reminder_controller.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/widgets/primary_circle_button.dart';
import 'package:numberpicker/numberpicker.dart';

class AddPushSlide extends StatelessWidget {
  final PageController _pageController;
  ReminderController reminderController;
  AddPushSlide(this._pageController, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    reminderController = Get.put(ReminderController());
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(),
          Text(
            'welcome_push_title'.tr,
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.white,
                fontSize: Get.width * .06,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 20),
          Text(
            'welcome_push_subtitle'.tr,
            style: TextStyle(color: Colors.white60, fontSize: Get.width * .042),
          ),
          const Spacer(),
          buildNumberPicker(),
          const Spacer(),
          Center(child: buildButton()),
          Center(child: buildSkipButton()),
          const Spacer(),
        ],
      ),
    );
  }

  var hours = 11.obs;
  var min = 30.obs;
  Widget buildNumberPicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(
          () => NumberPicker(
            value: hours.value,
            minValue: 0,
            maxValue: 23,
            step: 1,
            itemHeight: 50,
            axis: Axis.vertical,
            onChanged: hours,
            textStyle: const TextStyle(color: Colors.white70),
            selectedTextStyle: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.white),
                bottom: BorderSide(color: Colors.white),
              ),
            ),
          ),
        ),
        Obx(
          () => NumberPicker(
            value: min.value,
            minValue: 0,
            maxValue: 59,
            step: 1,
            itemHeight: 50,
            axis: Axis.vertical,
            onChanged: min,
            textStyle: const TextStyle(color: Colors.white70),
            selectedTextStyle: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.white),
                bottom: BorderSide(color: Colors.white),
              ),
            ),
          ),
        )
      ],
    );
  }

  PrimaryCircleButton buildButton() {
    return PrimaryCircleButton(
      size: 40,
      icon: const Icon(Icons.arrow_forward, color: AppColors.primary),
      onPressed: () {
        reminderController.addReminder(
           timeOfDay: TimeOfDay(hour: hours.value, minute: min.value),
          activeAllDaysByDefault: true,
          onAction: () {
            // AppRouting.replace(MainMenuPage());
            AppMetrica.reportEvent('onbording_time_set');
            _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn);
          },
        );
        // _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeIn);
      },
    );
  }

  CupertinoButton buildSkipButton() {
    return CupertinoButton(
      child: Text(
        'skip'.tr,
        style: const TextStyle(color: Colors.white54),
      ),
      onPressed: () {
        // AppRouting.replace(MainMenuPage());
        AppMetrica.reportEvent('onbording_time_skip');
        _pageController.nextPage(
            duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
      },
    );
  }
}
