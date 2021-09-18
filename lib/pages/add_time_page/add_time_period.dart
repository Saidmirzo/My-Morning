import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/pages/reading/timer/timer_page.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/services/timer_service.dart';

class AddTimePeriod extends StatelessWidget {
  final TimerService timerService;
  final bool nightMode;
  GlobalKey _scaffoldKey = GlobalKey();

  AddTimePeriod({Key key, @required this.timerService, this.nightMode = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: Get.width,
        decoration: BoxDecoration(
          gradient: AppColors.Bg_Gradient_Timer_Reading,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              bottom: 0,
              child: Container(
                color: AppColors.VIOLET,
                width: Get.width,
                child: nightMode == false
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
                  button('x_minutes'.trParams({'x': '1'}), min: 1),
                  button('x_minutes'.trParams({'x': '2'}), min: 2),
                  button('x_minutes'.trParams({'x': '3'}), min: 3),
                  button('x_minutes'.trParams({'x': '4'}), min: 4),
                  button('x_minutes'.trParams({'x': '5'}), min: 5),
                  button('own_time'.tr, btnColor: Color(0xff592F72),
                      onPressed: () async {
                    Duration _duration = await showDurationPicker(
                      context: context,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      initialTime: Duration(minutes: 10),
                    );
                    if (_duration != null) {
                      timerService.setTime(_duration.inMinutes ?? 0);
                      Get.back();
                    }
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget button(String title, {int min, Function onPressed, Color btnColor}) {
    return CupertinoButton(
      padding: const EdgeInsets.symmetric(vertical: 10),
      onPressed: onPressed ??
          () {
            timerService.setTime(min ?? 0);
            Get.back();
          },
      child: Container(
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
        width: Get.width * .8,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: btnColor ?? Color(0xffB77CAC)),
      ),
    );
  }
}
