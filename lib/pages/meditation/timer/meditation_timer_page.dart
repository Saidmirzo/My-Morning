import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:morningmagic/features/meditation_audio/presentation/controller/meditation_audio_controller.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/services/analitics/analyticService.dart';
import 'package:morningmagic/services/timer_service.dart';
import 'package:morningmagic/utils/string_util.dart';
import 'package:screen/screen.dart';

import 'components/components.dart';

class MeditationTimerPage extends StatefulWidget {
  @override
  State createState() => MeditationTimerPageState();
}

class MeditationTimerPageState extends State<MeditationTimerPage>
    with WidgetsBindingObserver {
  MediationAudioController _audioController;
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
    _audioController = Get.find();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _audioController.initializeMeditationAudio();
      await timerService.init(1, _audioController.player);
    });

    AnalyticService.screenView('meditation_timer_page');
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
        _audioController.player.stop();
        return true;
      },
      child: Scaffold(
        body: Container(
          height: Get.height,
          decoration: BoxDecoration(
            gradient: AppColors.Bg_Gradient_Timer_Meditation,
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
                        color: AppColors.primary,
                      ))),
                  Spacer(),
                  Obx(() {
                    if (_audioController.isAudioLoading.value &&
                        !_audioController.isPlaylistAudioCached)
                      return buildAudioLoading();
                    else
                      return buildPlayerControls();
                  }),
                  Container(
                      width: Get.width * 0.8,
                      alignment: Alignment.center,
                      child: Obx(() => Text(
                            _audioController.currAudioName.value,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.clip,
                          ))),
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
    MediationAudioController cAudio = Get.find();
    cAudio.dispose();
  }
}
