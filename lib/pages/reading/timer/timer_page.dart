import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/routing/timer_page_ids.dart';
import 'package:morningmagic/services/analitics/analyticService.dart';
import 'package:morningmagic/services/timer_left.dart';
import 'package:morningmagic/services/timer_service.dart';
import 'package:morningmagic/storage.dart';
import 'package:morningmagic/utils/string_util.dart';
import 'package:screen/screen.dart';

import 'components/components.dart';

class ReadingTimerPage extends StatefulWidget {
  final bool fromHomeMenu;
  final TimerService timerService;

  const ReadingTimerPage({
    Key key,
    this.fromHomeMenu = false,
    this.timerService,
  }) : super(key: key);
  @override
  State createState() => ReadingTimerPageState();
}

class ReadingTimerPageState extends State<ReadingTimerPage>
    with WidgetsBindingObserver {
  TimerService timerService;
  TimerLeftController cTimerLeft;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      cTimerLeft.onAppLeft(timerService.timer, timerService.time.value,
          onPlayPause: () => timerService.startTimer());
    } else if (state == AppLifecycleState.resumed) {
      cTimerLeft.onAppResume(
          timerService.timer, timerService.time, timerService.passedSec);
    }
  }

  @override
  void initState() {
    timerService =
        widget.timerService == null ? TimerService() : widget.timerService;
    cTimerLeft = TimerLeftController();
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await timerService.init(TimerPageId.Reading);
      timerService.fromHomeMenu = widget.fromHomeMenu;
    });
    AnalyticService.screenView('reading_timer_page');
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
            gradient: menuState == MenuState.MORNING
                ? AppColors.Bg_Gradient_Timer_Reading
                : AppColors.gradient_loading_night_bg,
          ),
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                child: Container(
                    width: Get.width,
                    child: Image.asset(
                      menuState == MenuState.MORNING
                          ? 'assets/images/timer/clouds_timer.png'
                          : 'assets/images/reading_night/clouds.png',
                      fit: BoxFit.cover,
                    )),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Spacer(),
                  buildTimerProgress(timerService),
                  const SizedBox(height: 20),
                  Obx(() => Text(
                      StringUtil.createTimeString(
                        timerService.time.value,
                      ),
                      style: TextStyle(
                        fontSize: Get.height * 0.033,
                        fontWeight: FontWeight.w600,
                        color: menuState == MenuState.MORNING
                            ? AppColors.primary
                            : AppColors.WHITE,
                      ))),
                  Spacer(),
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
    Get.delete<TimerLeftController>();
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    timerService.dispose();
  }
}
