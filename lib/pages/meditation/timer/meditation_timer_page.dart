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
import 'package:morningmagic/utils/other.dart';
import 'package:morningmagic/utils/string_util.dart';
import 'package:screen/screen.dart';

import '../meditation_audio_page.dart';
import 'components/components.dart';

class MeditationTimerPage extends StatefulWidget {
  final bool fromAudio;
  final bool fromHomeMenu;

  const MeditationTimerPage(
      {Key key, this.fromAudio = false, this.fromHomeMenu = false})
      : super(key: key);
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
      print('MeditationTimerPage addPostFrameCallback');
      _audioController.initializeMeditationAudio(autoplay: widget.fromAudio);
      await timerService.init(1, _audioController.player);
      timerService.fromHomeMenu = widget.fromHomeMenu;
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
        print('MeditationTimerPage willPopScope');
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
              Obx(() => _audioController.withBgSound.value
                  ? Positioned(
                      top: Get.height * .20,
                      left: 20,
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Icon(Icons.volume_up, color: Colors.black45),
                              RotatedBox(
                                quarterTurns: -1,
                                child: SizedBox(
                                  width: Get.height * .33,
                                  child: Obx(() => Slider(
                                        value: _audioController
                                            .bgAudioPlayer.value.volume,
                                        min: 0,
                                        max: 1,
                                        onChanged:
                                            _audioController.changeBgValume,
                                      )),
                                ),
                              ),
                              Icon(Icons.volume_off, color: Colors.black45),
                            ],
                          ),
                          GestureDetector(
                              onTap: () {
                                _audioController.bgAudioPlayer?.value?.pause();
                                _audioController.pause();
                                Get.to(MeditationAudioPage(
                                    fromTimerPage: true, withBgSound: true));
                              },
                              child: Icon(Icons.library_music,
                                  color: Colors.black54)),
                        ],
                      ),
                    )
                  : SizedBox()),
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
                    if (_audioController != null &&
                        _audioController.isAudioLoading.value &&
                        !_audioController.isPlaylistAudioCached)
                      return buildAudioLoading();
                    else
                      return buildPlayerControls();
                  }),
                  Container(
                      width: Get.width * 0.8,
                      alignment: Alignment.center,
                      child: Obx(() {
                        var duration = (_audioController?.withBgSound?.value ??
                                false)
                            ? _audioController
                                .audioSource[
                                    _audioController?.selectedItemIndex?.value]
                                .duration
                            : null;
                        return Row(
                          children: [
                            if (duration != null)
                              Text(printDuration(
                                  _audioController.durationPosition.value,
                                  h: false)),
                            const SizedBox(width: 10),
                            Expanded(
                              child: LinearProgressIndicator(
                                  value:
                                      _audioController.percentDuration.value),
                            ),
                            const SizedBox(width: 10),
                            if (duration != null)
                              Text(
                                printDuration(duration, h: false),
                              ),
                          ],
                        );
                      })),
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
    // _audioController.dispose();
  }
}
