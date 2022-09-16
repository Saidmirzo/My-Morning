import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:get/get.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/model/exercise_time/exercise_time.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/pages/reading/reading_provider.dart';
import 'package:morningmagic/pages/reading/timer/timer_page.dart';
import 'package:morningmagic/services/timer_service.dart';
import 'package:morningmagic/storage.dart';
import 'package:provider/provider.dart';
import '../pages/affirmation/timer/timer_page.dart';

class TimerBlock extends StatelessWidget {
  TimerBlock(
      {Key key,
      this.fromHomeMenu,
      this.timerService,
      this.mycolorbool = false,
      this.title,
      this.isaformation})
      : super(key: key);
  final TimerService timerService;
  final bool fromHomeMenu;
  final bool isaformation;
  final String title;
  final mycolorbool;

  final List minuteButtonsTexts = [
    '${myDbBox.get(MyResource.READING_TIME_KEY).time ?? 5} ${'min 1'.tr}',
    '10 min'.tr,
    '15 min'.tr,
  ];
  final List minuteButtonsTextstwo = [
    '${myDbBox.get(MyResource.AFFIRMATION_TIME_KEY).time ?? 1} ${'min 1'.tr}',
    '2 min'.tr,
    '3 min'.tr,
  ];

  @override
  Widget build(BuildContext context) {
    ReadingProvider prov = context.watch<ReadingProvider>();
    return Expanded(
      flex: 26,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 31),
        width: double.maxFinite,
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(19),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  const Spacer(
                    flex: 6,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Montserrat',
                      color: menuState == MenuState.MORNING
                          ? const Color(0xff592F72)
                          : Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(
                    flex: 4,
                  ),
                  Expanded(
                    flex: 9,
                    child: Row(
                      children: List.generate(
                        5,
                        (i) => i == 1 || i == 3
                            ? const SizedBox(
                                width: 9.12,
                              )
                            : MinuteButton(
                                isafirm: isaformation,
                                bgColor: getCondition(isaformation, prov, i)
                                    ? menuState == MenuState.MORNING
                                        ? const Color(0xff592F72)
                                        : const Color(0xffF3E2FF)
                                    : const Color.fromRGBO(255, 255, 255, 1)
                                        .withOpacity(.83),
                                text: isaformation == true
                                    ? minuteButtonsTextstwo[i == 2
                                        ? i - 1
                                        : i == 4
                                            ? i - 2
                                            : i]
                                    : minuteButtonsTexts[i == 2
                                        ? i - 1
                                        : i == 4
                                            ? i - 2
                                            : i],
                                textColor: getCondition(isaformation, prov, i)
                                    ? menuState == MenuState.MORNING
                                        ? const Color(0xffFFFEFE)
                                        : const Color(0xff592F72)
                                    : const Color(0xff592F72),
                                onClick: () {
                                  myDbBox.put(
                                      "time_selection_type_${isaformation ? "afirm" : "reading"}",
                                      "special");

                                  int readingValue = (myDbBox
                                              .get(MyResource.READING_TIME_KEY)
                                              .time ??
                                          5) *
                                      60;
                                  int afirmationValue = (myDbBox
                                              .get(MyResource
                                                  .AFFIRMATION_TIME_KEY)
                                              .time ??
                                          1) *
                                      60;
                                  if (menuState == MenuState.MORNING) {
                                    if (!isaformation) {
                                      String text = minuteButtonsTexts[i == 2
                                              ? i - 1
                                              : i == 4
                                                  ? i - 2
                                                  : i]
                                          .toString()
                                          .split(" ")
                                          .first;

                                      timerService.setTime(i == 0
                                          ? readingValue
                                          : i == 2
                                              ? 10 * 60
                                              : 15 * 60);
                                      myDbBox.put(MyResource.READING_TIME_KEY,
                                          ExerciseTime(int.parse(text)));
                                    } else {
                                      String text = minuteButtonsTextstwo[i == 2
                                              ? i - 1
                                              : i == 4
                                                  ? i - 2
                                                  : i]
                                          .toString()
                                          .split(" ")
                                          .first;
                                      timerService.setTime(i == 0
                                          ? afirmationValue
                                          : i == 2
                                              ? 2 * 60
                                              : 3 * 60);
                                      myDbBox.put(
                                          MyResource.AFFIRMATION_TIME_KEY,
                                          ExerciseTime(int.parse(text)));
                                    }
                                  } else {
                                    if (!isaformation) {
                                      String text = minuteButtonsTexts[i == 2
                                              ? i - 1
                                              : i == 4
                                                  ? i - 2
                                                  : i]
                                          .toString()
                                          .split(" ")
                                          .first;
                                      timerService.setTime(i == 0
                                          ? readingValue
                                          : i == 2
                                              ? 10 * 60
                                              : 15 * 60);
                                      myDbBox.put(MyResource.READING_TIME_KEY,
                                          ExerciseTime(int.parse(text)));
                                    } else {
                                      String text = minuteButtonsTextstwo[i == 2
                                              ? i - 1
                                              : i == 4
                                                  ? i - 2
                                                  : i]
                                          .toString()
                                          .split(" ")
                                          .first;
                                      timerService.setTime(i == 0
                                          ? afirmationValue
                                          : i == 2
                                              ? 2 * 60
                                              : 3 * 60);
                                      myDbBox.put(
                                          MyResource.AFFIRMATION_TIME_KEY,
                                          ExerciseTime(int.parse(text)));
                                    }
                                  }
                                  prov.onSelect(i);
                                },
                              ),
                      ),
                    ),
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                  CustomTimeButton(
                    bgColor: (myDbBox.get(
                                    "time_selection_type_${isaformation ? "afirm" : "reading"}") ??
                                "special") ==
                            "custom"
                        ? menuState == MenuState.MORNING
                            ? const Color(0xff592F72)
                            : const Color(0xffF3E2FF)
                        : const Color.fromRGBO(255, 255, 255, 1)
                            .withOpacity(.83),
                    textColor: (myDbBox.get(
                                    "time_selection_type_${isaformation ? "afirm" : "reading"}") ??
                                "special") ==
                            "custom"
                        ? menuState == MenuState.MORNING
                            ? const Color(0xffFFFEFE)
                            : const Color(0xff592F72)
                        : const Color(0xff592F72),
                    gotoafirm: isaformation,
                    timerService: timerService,
                    fromHomeMenu: fromHomeMenu,
                  ),
                  const Spacer(
                    flex: 4,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool getCondition(bool condition, ReadingProvider prov, int i) {
    bool first = (myDbBox.get(
                "time_selection_type_${isaformation ? "afirm" : "reading"}") ??
            "special") ==
        "special";
    return first ? prov.selectedButtonIndex == i : false;
  }
}

class MinuteButton extends StatelessWidget {
  const MinuteButton(
      {Key key,
      this.bgColor,
      this.textColor,
      this.text,
      this.onClick,
      this.isafirm})
      : super(key: key);
  final Color bgColor;
  final Color textColor;
  final String text;
  final bool isafirm;
  final VoidCallback onClick;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onClick,
        child: Container(
          alignment: Alignment.center,
          height: double.maxFinite,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(17.57), color: bgColor),
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 12.95,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTimeButton extends StatelessWidget {
  const CustomTimeButton(
      {Key key,
      this.fromHomeMenu,
      this.timerService,
      this.gotoafirm,
      this.bgColor,
      this.textColor})
      : super(key: key);
  final TimerService timerService;
  final bool fromHomeMenu;
  final bool gotoafirm;
  final Color bgColor;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 9,
      child: GestureDetector(
        onTap: () async {
          // TimerService timerService = TimerService();
          Duration _duration = await showDurationPicker(
            context: context,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            initialTime: const Duration(minutes: 10),
          );
          if (_duration != null) {
            myDbBox.put(
                gotoafirm
                    ? MyResource.AFFIRMATION_TIME_KEY
                    : MyResource.READING_TIME_KEY,
                ExerciseTime(_duration.inMinutes ?? 5));
            myDbBox.put(
                "time_selection_type_${gotoafirm ? "afirm" : "reading"}",
                "custom");
            timerService.setTime(_duration.inSeconds ?? 0);
            gotoafirm != true
                ? Get.to(
                    ReadingTimerPage(
                      timerService: timerService,
                      fromHomeMenu: fromHomeMenu,
                    ),
                  )
                : Get.to(
                    AffirmationTimerPage(
                      timerService: timerService,
                      fromHomeMenu: fromHomeMenu,
                    ),
                  );
          }
        },
        child: Container(
          width: double.maxFinite,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(17.57),
          ),
          child: Text(
            'Set your own time'.tr,
            style: TextStyle(
              color: textColor,
              fontSize: 12.95,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
          ),
        ),
      ),
    );
  }
}
