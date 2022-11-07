import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/pages/reading/reading_page.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/routing/timer_page_ids.dart';
import 'package:morningmagic/services/analitics/all.dart';
import 'package:morningmagic/services/analitics/analyticService.dart';
import 'package:morningmagic/services/timer_left.dart';
import 'package:morningmagic/services/timer_service.dart';
import 'package:morningmagic/storage.dart';
import 'package:morningmagic/utils/string_util.dart';
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

class ReadingTimerPageState extends State<ReadingTimerPage> with WidgetsBindingObserver {
  TimerService timerService;
  TimerLeftController cTimerLeft;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      cTimerLeft.onAppLeft(timerService.timer, timerService.time.value, onPlayPause: () => timerService.startTimer());
    } else if (state == AppLifecycleState.resumed) {
      cTimerLeft.onAppResume(timerService.timer, timerService.time, timerService.passedSec);
    }
  }

  @override
  void initState() {
    timerService = widget.timerService ?? TimerService();
    cTimerLeft = TimerLeftController();
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await timerService.init(TimerPageId.Reading);
      timerService.fromHomeMenu = widget.fromHomeMenu;
    });
    AnalyticService.screenView('reading_timer_page');
    try {
      // Screen.keepOn(true);
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
                ? AppColors.bgGradientTimerReading
                : AppColors.gradientLoadingNightBg,
          ),
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                child: SizedBox(
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
                  const SizedBox(
                    height: 67,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                          alignment: Alignment.topLeft,
                          child: Row(
                            children: [
                              GestureDetector(
                                  child: const Padding(
                                    padding: EdgeInsets.only(left: 31),
                                    child: Icon(
                                      Icons.west,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                  onTap: () {
                                    timerService.dispose();
                                    // Navigator.pop(context);
                                    Get.to(() => const ReadingPage());
                                  }),
                            ],
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 70,
                  ),

                  buildTimerProgress(timerService),
                  const SizedBox(height: 20),
                  Obx(() => Text(
                      StringUtil.createTimeString(
                        timerService.time.value,
                      ),
                      style: TextStyle(
                        fontSize: Get.height * 0.033,
                        fontWeight: FontWeight.w600,
                        color: menuState == MenuState.MORNING ? AppColors.primary : AppColors.white,
                      ))),
                  const Spacer(),
                  ReadMyButton(timerService: timerService),
                  // buildMenuButtons(timerService),
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

class ReadMyButton extends StatelessWidget {
  const ReadMyButton({Key key, this.onClick, this.timerService}) : super(key: key);
  final VoidCallback onClick;
  final TimerService timerService;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: GestureDetector(
        onTap: () {
          timerService.skipTask();
          // appAnalitics.logEvent('first_reading_next');
        },
        child: Container(
          height: 70,
          width: double.maxFinite,
          margin: const EdgeInsets.symmetric(horizontal: 31),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: menuState == MenuState.MORNING ? const Color(0xff592F72) : Colors.white,
            borderRadius: BorderRadius.circular(19),
          ),
          child: Text(
            'Finish reading'.tr,
            style: TextStyle(
              color: menuState == MenuState.MORNING ? Colors.white : const Color(0xff592F72),
              fontWeight: FontWeight.w600,
              fontFamily: 'Montserrat',
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
