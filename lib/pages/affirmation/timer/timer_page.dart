import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/services/analitics/analyticService.dart';
import 'package:morningmagic/services/timer_service.dart';
import 'package:morningmagic/utils/string_util.dart';
import 'package:screen/screen.dart';

import 'components/components.dart';

class AffirmationTimerPage extends StatefulWidget {
  @override
  State createState() => AffirmationTimerPageState();
}

class AffirmationTimerPageState extends State<AffirmationTimerPage>
    with WidgetsBindingObserver {
  TimerService timerService = TimerService();

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      timerService.onAppLeft();
    } else if (state == AppLifecycleState.resumed) {
      timerService.onAppResume();
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await timerService.init(0, null);
    });
    AnalyticService.screenView('affirmation_timer_page');
    try {
      Screen.keepOn(true);
    } catch (e) {
      log('Screen.keepOn : ' + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    print('build timer page');
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        body: Container(
          height: Get.height,
          decoration: BoxDecoration(
            gradient: AppColors.Bg_Gradient_Timer_Affirmation,
          ),
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                child: Container(
                  width: Get.width,
                  child: Image.asset(
                    'assets/images/timer/clouds_timer.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Spacer(),
                  buildTimerProgress(timerService),
                  const SizedBox(height: 20),
                  Obx(() => Text(StringUtil.createTimeString(timerService.time),
                      style: TextStyle(
                        fontSize: Get.height * 0.033,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ))),
                  Spacer(),
                  Spacer(),
                  Obx(() => timerService.affirmationText.value.isNotEmpty
                      ? buildTitleWidget(timerService.affirmationText.value)
                      : SizedBox()),
                  Spacer(),
                  Spacer(),
                  buildMenuButtons(timerService),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    timerService.dispose();
  }
}