import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/routing/timer_page_ids.dart';
import 'package:morningmagic/services/timer_service.dart';
import '../../storage.dart';

class AddTimePeriod extends StatelessWidget {
  final TimerService timerService;
  final int pageId;

  final GlobalKey _scaffoldKey = GlobalKey();

  AddTimePeriod({Key key, @required this.timerService, this.pageId = -1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: Get.width,
        decoration: BoxDecoration(
          gradient: menuState == MenuState.MORNING
              ? AppColors.bgGradientTimerReading
              : AppColors.timerBgNight,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              bottom: 0,
              child: SizedBox(
                width: Get.width,
                child: menuState == MenuState.MORNING
                    ? Image.asset(
                        'assets/images/timer/clouds_timer.png',
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
            ),
            SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  button('dont_add_time'.tr, onPressed: () => Get.back()),
                  button('x_minutes'.trParams({'x': '1'}),
                      min: 1, pageId: pageId),
                  button('x_minutes'.trParams({'x': '2'}),
                      min: 2, pageId: pageId),
                  button('x_minutes'.trParams({'x': '3'}),
                      min: 3, pageId: pageId),
                  button('x_minutes'.trParams({'x': '4'}),
                      min: 4, pageId: pageId),
                  button('x_minutes'.trParams({'x': '5'}),
                      min: 5, pageId: pageId),
                  button(
                    'own_time'.tr,
                    btnColor: menuState == MenuState.MORNING
                        ? const Color(0xff592F72)
                        : const Color(0xff040826),
                    onPressed: () async {
                      Duration _duration = await showDurationPicker(
                        context: context,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        initialTime: const Duration(minutes: 10),
                      );
                      if (_duration != null) {
                        menuState == MenuState.MORNING
                            ? timerService.setTime(_duration.inSeconds ?? 0)
                            : pageId == TimerPageId.MeditationNight
                                ? timerService
                                    .setNightTime(_duration.inSeconds ?? 0)
                                : timerService
                                    .setTime(_duration.inSeconds ?? 0);
                        Get.back();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget button(String title,
      {int min, Function onPressed, Color btnColor, int pageId}) {
    return CupertinoButton(
      padding: const EdgeInsets.symmetric(vertical: 10),
      onPressed: onPressed ??
          () {
            menuState == MenuState.MORNING
                ? timerService.setTime(min * 60 ?? 0)
                : pageId == TimerPageId.MeditationNight
                    ? timerService.setNightTime((min * 60 ?? 0))
                    : timerService.setTime(min * 60 ?? 0);
            Get.back();
          },
      child: Container(
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white),
        ),
        width: Get.width * .8,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: btnColor ??
                (menuState == MenuState.NIGT
                    ? AppColors.timerNightBgButton
                    : const Color(0xffB77CAC))),
      ),
    );
  }
}
