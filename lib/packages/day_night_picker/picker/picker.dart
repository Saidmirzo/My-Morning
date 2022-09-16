import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:get/get.dart';
import 'package:morningmagic/packages/day_night_picker/providers/day_night_picker_provider.dart';
import 'package:morningmagic/packages/day_night_picker/utils/day_night_banner.dart';
import 'package:morningmagic/pages/reminders/reminder_controller.dart';
import 'package:provider/provider.dart';

class DayNightTimePicker extends StatelessWidget {
  DayNightTimePicker({Key key}) : super(key: key);
  final ReminderController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    PickerProvider prov = context.watch<PickerProvider>();
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 3,
                  sigmaY: 3,
                ),
                child: Container(
                  color: Colors.white10,
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 31),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(19),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      children: [
                        DayNightBanner(
                          hour: prov.hour,
                        ),
                        Positioned(
                          right: 18,
                          top: 18,
                          child: GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child:
                                  const Icon(Icons.close, color: Colors.white)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        clickableText(
                          onClick: () {
                            prov.selectTimeType(true);
                          },
                          text: prov.hour.toString(),
                        ),
                        clickableText(),
                        clickableText(
                          onClick: () {
                            prov.selectTimeType(false);
                          },
                          text: prov.minute.toString(),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Slider(
                      value: double.parse(
                          (prov.isSelectedHour ? prov.hour : prov.minute)
                              .toString()),
                      min: 0,
                      max: prov.isSelectedHour ? 23 : 59,
                      activeColor: const Color(0xff592F72),
                      inactiveColor: const Color(0xff592F72).withOpacity(.07),
                      onChanged: (val) {
                        if (prov.isSelectedHour) {
                          prov.changeHour(val);
                        } else {
                          prov.changeMinute(val);
                        }
                      },
                    ),
                    const SizedBox(
                      height: 11.21,
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.selectedTime =
                            TimeOfDay(hour: prov.hour, minute: prov.minute);
                        Get.back();
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 9.66, vertical: 12.21),
                        width: double.maxFinite,
                        height: 68.63,
                        decoration: BoxDecoration(
                          color: const Color(0xff592F72),
                          borderRadius: BorderRadius.circular(19),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'al'.tr,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 13,
              ),
              SizedBox(
                width: Get.width * .8,
                child: Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      dayBtn('monday_short'.tr, 1),
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
        ],
      ),
    );
  }

  Widget clickableText({VoidCallback onClick, String text = ":"}) {
    return GestureDetector(
      onTap: onClick,
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 48,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget dayBtn(String item, int index) {
    bool isActive = controller.activeDays.value.contains(index);
    return GestureDetector(
      onTap: () {
        isActive
            ? controller.activeDays.value.remove(index)
            : controller.activeDays.value.add(index);
      },
      child: Container(
        margin: const EdgeInsets.all(1),
        padding: const EdgeInsets.all(5),
        height: 50,
        width: (Get.width / 7) * .7,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isActive ? const Color(0xff592F72) : Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(item,
            style: TextStyle(
                fontSize: 11,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                color: isActive ? Colors.white : Colors.black)),
      ),
    );
  }
}
