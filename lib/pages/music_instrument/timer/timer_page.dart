import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/features/instruments_audio/controllers/instruments_audio_controller.dart';
import 'package:morningmagic/pages/music_instrument/timer/components/player_instrument.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/routing/timer_page_ids.dart';
import 'package:morningmagic/services/analitics/analyticService.dart';
import 'package:morningmagic/services/timer_left.dart';
import 'package:morningmagic/services/timer_service.dart';
import 'package:morningmagic/storage.dart';
import 'package:morningmagic/utils/string_util.dart';
import 'package:morningmagic/widgets/primary_circle_button.dart';
import '../music_instrument_page.dart';
import 'components/components.dart';

class InstrumentTimerPage extends StatefulWidget {
  final bool fromHomeMenu;
  final TimerService timerService;

  const InstrumentTimerPage({
    Key key,
    this.fromHomeMenu = false,
    this.timerService,
  }) : super(key: key);
  @override
  State createState() => InstrumentTimerPageState();
}

class InstrumentTimerPageState extends State<InstrumentTimerPage>
    with WidgetsBindingObserver {
  TimerService timerService;
  TimerLeftController cTimerLeft;
  final InstrumentAudioController _audioController = Get.find();

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
    _audioController.timerService = timerService;
    cTimerLeft = TimerLeftController();
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await timerService.init(TimerPageId.MusicNight);
      timerService.fromHomeMenu = widget.fromHomeMenu;
      if (_audioController.isPause) {
        timerService.timer.cancel();
      }
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
                ? AppColors.Bg_Gradient_Timer_Reading
                : AppColors.gradient_loading_night_bg,
          ),
          child: SafeArea(
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  top: 0,
                  child: SizedBox(
                      width: Get.width,
                      child: Image.asset(
                        'assets/images/reading_night/clouds.png',
                        fit: BoxFit.fill,
                      )),
                ),
                Positioned(
                  top: 0,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
                    child: PrimaryCircleButton(
                      icon: const Icon(Icons.arrow_back,
                          color: AppColors.primary),
                      onPressed: () {
                        InstrumentAudioController controller = Get.find();
                        controller.stopAll();
                        timerService.dispose();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MusicInstrumentPage()),
                        );
                      },
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    const Spacer(),

                    //buildTimerProgress(timerService),
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
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Get.width / 4,
                          vertical: Get.height * 0.05),
                      child: instrumentPlayer(
                          audioController: _audioController,
                          timerService: timerService,
                          fromTimer: true),
                    ),
                    buildMenuButtons(timerService),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    InstrumentAudioController controller;
    try {
      controller = Get.find();
    } catch (e) {
      print(
          'Instrument audio controller not found, dispose instrument timer page');
    }

    if (controller == null) {
      Get.delete<TimerLeftController>();
      WidgetsBinding.instance.removeObserver(this);
      timerService.dispose();
    }
    super.dispose();
  }
}
