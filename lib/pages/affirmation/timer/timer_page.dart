import 'dart:developer';
import 'package:morningmagic/pages/affirmation/affirmation_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/services/analitics/analyticService.dart';
import 'package:morningmagic/services/timer_left.dart';
import 'package:morningmagic/services/timer_service.dart';
import 'package:morningmagic/utils/string_util.dart';
import 'package:wakelock/wakelock.dart';
import '../../../services/analitics/all.dart';
import '../affirmation_dialog/affirmation_dialog.dart';
import 'components/components.dart';

class AffirmationTimerPage extends StatefulWidget {
  final bool fromHomeMenu;
  final TimerService timerService;
  const AffirmationTimerPage(
      {Key key, this.fromHomeMenu = false, this.timerService})
      : super(key: key);
  @override
  State createState() => AffirmationTimerPageState();
}

class AffirmationTimerPageState extends State<AffirmationTimerPage>
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
    timerService = widget.timerService ?? TimerService();
    cTimerLeft = TimerLeftController();
    Wakelock.enable();
    super.initState();

    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await timerService.init(0);
      timerService.fromHomeMenu = widget.fromHomeMenu;
      timerService.startTimer();
    });
    AnalyticService.screenView('affirmation_timer_page');
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
          decoration: const BoxDecoration(
            gradient: AppColors.bgGradientTimerAffirmation,
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
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const AffirmationPage(
                                                  fromHomeMenu: false,
                                                )));
                                  }),
                            ],
                          ))
                    ],
                  ),
                  const Spacer(),
                  buildTimerProgress(timerService),
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
                  const Spacer(
                    flex: 2,
                  ),
                  Obx(() => timerService.affirmationText.value.isNotEmpty
                      ? buildTitleWidget(timerService.affirmationText.value,context)
                      : const SizedBox()),
                  const Spacer(flex: 2),

                  // buildTitleWidget("affirmation text"),

                  const SizedBox(height: 37),
                  GestureDetector(
                    onTap: () async {
                      final _affirmation =
                          await Get.dialog(const AffirmationCategoryDialog());
                      if (_affirmation != null) {
                        timerService.affirmationText.value =
                            _affirmation.toString();
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Container(
                        height: 65,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(19),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            'Choose an affirmation'.tr,
                            style: const TextStyle(
                              color: Color(0xff592F72),
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await timerService.skipTask();
                      appAnalitics.logEvent('first_affirmation_next');
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

                  //buildMenuButtons(timerService),
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
