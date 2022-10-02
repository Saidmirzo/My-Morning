import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/services/analitics/analyticService.dart';
import 'package:morningmagic/services/timer_left.dart';
import 'package:morningmagic/services/timer_service.dart';
import 'package:morningmagic/utils/string_util.dart';
import 'package:morningmagic/widgets/timer_circle_button.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'custom_sucsses.dart';

class CustomMethodicPage extends StatefulWidget {
  final int pageId;
  const CustomMethodicPage({Key key, @required this.pageId}) : super(key: key);

  @override
  State<CustomMethodicPage> createState() => _CustomMethodicPageState();
}

class _CustomMethodicPageState extends State<CustomMethodicPage>
    with WidgetsBindingObserver {
  TimerService timerService = TimerService();
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
    cTimerLeft = TimerLeftController();
    super.initState();

    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await timerService.init(widget.pageId);
      timerService.startTimer();
    });
    AnalyticService.screenView('custom_timer_page');
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
          width: Get.width,
          decoration: const BoxDecoration(
            gradient: AppColors.Bg_Gradient_Timer_Affirmation,
          ),
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                child: SizedBox(
                  width: Get.width,
                  child: Image.asset(
                    'assets/images/timer/clouds_timer.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 48),
                      child: GestureDetector(
                        child: const Padding(
                          padding: EdgeInsets.only(left: 27),
                          child: Icon(
                            Icons.west,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        onTap: () {
                          timerService.dispose();
                          Get.back();
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height * 0.15),
                  Center(
                    child: Obx(
                      () => CircularPercentIndicator(
                        radius: Get.height * 0.18,
                        lineWidth: 15.0,
                        animation: false,
                        percent: timerService.createValue > 1.0
                            ? 1
                            : timerService.createValue,
                        center: TimerCircleButton(
                            child: Icon(
                              timerService.isActive.isTrue
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              size: 40,
                              color: AppColors.VIOLET,
                            ),
                            onPressed: () => timerService.startTimer()),
                        circularStrokeCap: CircularStrokeCap.round,
                        linearGradient:
                            AppColors.Progress_Gradient_Timer_Affirmation,
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Obx(() => Text(
                      StringUtil.createTimeString(
                        timerService.time.value,
                      ),
                      style: TextStyle(
                        fontSize: Get.height * 0.033,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ))),
                  const Spacer(),
                  GestureDetector(
                    onTap: () async {
                      await timerService.skipTask();
                      Get.off(() => CastomSuccessPage(
                          fromHomeMenu: false,
                          percentValue: 1,
                          pageid: widget.pageId,
                      ));
                      //predicate: ModalRoute.withName(settingsPageRoute));
                      //appAnalitics.logEvent('first_affirmation_next');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Container(
                        height: 65,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(19),
                          color: const Color(0xff592F72),
                        ),
                        child: Center(
                          child: Text(
                            'Complete'.tr,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 27,
                  ),
                  // const Spacer(),
                  // Container(
                  //   decoration: const BoxDecoration(
                  //       borderRadius:
                  //           BorderRadius.vertical(top: Radius.circular(30)),
                  //       color: Colors.white),
                  //   child: SafeArea(
                  //     top: false,
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //       children: <Widget>[
                  //         CupertinoButton(
                  //             child: SvgPicture.asset(
                  //               SvgAssets.home,
                  //               width: 30,
                  //               height: 30,
                  //             ),
                  //             onPressed: () {
                  //               timerService.goToHome();
                  //             }),
                  //         CupertinoButton(
                  //           child: SvgPicture.asset(
                  //             SvgAssets.forward,
                  //             width: 30,
                  //             height: 30,
                  //           ),
                  //           onPressed: () {
                  //             timerService.skipTask();
                  //             appAnalitics.logEvent('first_affirmation_next');
                  //           },
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
