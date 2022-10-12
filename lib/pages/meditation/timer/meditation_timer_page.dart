import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/pages/add_time_page/add_time_period.dart';
import 'package:morningmagic/pages/meditation/meditation_audio_page.dart';
import 'package:morningmagic/pages/meditation/meditation_page.dart';
import 'package:wakelock/wakelock.dart';
import 'package:morningmagic/features/meditation_audio/presentation/controller/meditation_audio_controller.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/routing/timer_page_ids.dart';
import 'package:morningmagic/services/analitics/analyticService.dart';
import 'package:morningmagic/services/timer_left.dart';
import 'package:morningmagic/services/timer_service.dart';
import 'package:morningmagic/storage.dart';
import 'package:morningmagic/utils/string_util.dart';
import 'components/components.dart';

class MeditationTimerPage extends StatefulWidget {
  final bool isSilence;
  final bool fromAudio;
  final int mystateNumber;
  final bool fromHomeMenu;
  final TimerService timerService;
  final bool isMeditation;
  const MeditationTimerPage({
    Key key,
    this.mystateNumber,
    this.isSilence = false,
    this.fromAudio = false,
    this.fromHomeMenu = false,
    this.timerService,
    this.isMeditation = false,
  }) : super(key: key);
  @override
  State createState() => MeditationTimerPageState();
}

class MeditationTimerPageState extends State<MeditationTimerPage>
    with WidgetsBindingObserver {
  MediationAudioController _audioController;
  TimerService timerService;
  TimerLeftController cTimerLeft;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      cTimerLeft.onAppLeft(
        timerService.timer,
        timerService.time.value,
        onPlayPause: () => timerService.startTimer(),
        player: _audioController.audioPlayer.value,
      );
    } else if (state == AppLifecycleState.resumed) {
      cTimerLeft.onAppResume(
          timerService.timer, timerService.time, timerService.passedSec);
    }
  }

  @override
  void initState() {
    // if (menuState == MenuState.MORNING) {
    timerService = widget.timerService ??
        TimerService(
            mystateNumber: widget.mystateNumber,
            fromHomeMenu: widget.fromHomeMenu);
    cTimerLeft = TimerLeftController();
    // }
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _audioController = Get.find();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!widget.isSilence) {
        _audioController.initializeMeditationAudio(autoplay: widget.fromAudio);
      }

      int pageId = TimerPageId.Meditation;

      await timerService.init(pageId, onDone: () async {
        await _audioController.player?.stop();
        await _audioController.player?.dispose();
        await _audioController.bgAudioPlayer?.value?.stop();
        await _audioController.bgAudioPlayer?.value?.dispose();
      }, stateNumber: widget.mystateNumber);

      timerService.fromHomeMenu = widget.fromHomeMenu;
      //if (menuState == MenuState.MORNING) timerService.startTimer();
      if (_audioController.isPlaying.isFalse) {
        _audioController.play();
      }
      // if (menuState == MenuState.NIGT && !timerService.resume) {
      //   timerService.startTimer();
      // }
    });

    Future.delayed(Duration.zero, () {
      if (!timerService.isActive.value) {
        timerService.startTimer();
        print(
            "-------------------------------------- Balus Dzez ----------------------------------------------");
        // Future.delayed(Duration(seconds: 1), () {
        //   if (timerService.timer == null) {
        //timerService.nightMeditationStart(_audioController.player.duration);
        //   }
        // });
      }
    });
    _audioController.timerService = timerService;

    AnalyticService.screenView('meditation_timer_page');
    try {
      // Screen.keepOn(true);
    } catch (e) {
      log('Screen.keepOn : ' + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    Wakelock.enable();
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Container(
          height: Get.height,
          decoration: BoxDecoration(
            gradient: menuState == MenuState.MORNING
                ? AppColors.Bg_Gradient_Timer_Meditation
                : AppColors.gradient_loading_night_bg,
          ),
          child: Stack(
            children: [
              Container(
                width: double.maxFinite,
                height: double.maxFinite,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/images/${menuState == MenuState.NIGT ? 'timer_page_night' : 'meditation_timer_bg'}.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Column(
                // mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  const Spacer(
                    flex: 3,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 31),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            timerService.timer.cancel();
                            _audioController.bfPlayer.value.stop();
                            _audioController.audioPlayer.value.stop();
                            _audioController.pause();
                            Get.to(const MeditationPage());
                          },
                          child: const Icon(
                            Icons.west,
                            color: Colors.white,
                            size: 30,
                          ),
                        )
                      ],
                    ),
                  ),
                  const Spacer(
                    flex: 5,
                  ),
                  buildTimerProgress(timerService, widget.isSilence),
                  const Spacer(
                    flex: 3,
                  ),
                  Obx(
                    () => Text(
                      StringUtil.createTimeString(timerService.time.value),
                      style: TextStyle(
                        fontSize: Get.height * 0.033,
                        fontWeight: FontWeight.w600,
                        color: menuState == MenuState.MORNING
                            ? AppColors.primary
                            : Colors.white,
                      ),
                    ),
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (!widget.isSilence || widget.isMeditation)
                        ControlButton(
                            img: 'assets/images/meditation/audio_icon.png',
                            imgW: 20.42,
                            imgH: 20.42,
                            onClick: () {
                              //////////////////////////////////
                              // _audioController.pause();
                              // timerService.timer.cancel();
                              Get.to(
                                MeditationAudioPage(
                                    isMeditation: widget.isMeditation,
                                    timerService: timerService),
                              );
                            }),
                      if (_audioController.audioSource.isEmpty ||
                          !widget.isMeditation)
                        ControlButton(
                          img: 'assets/images/meditation/clock_icon.png',
                          imgW: 17.57,
                          imgH: 20.33,
                          onClick: () =>
                              Get.to(AddTimePeriod(timerService: timerService)),
                        ),
                    ],
                  ),
                  const Spacer(
                    flex: 10,
                  ),
                  Expanded(
                    flex: 6,
                    child: GestureDetector(
                      onTap: () {
                        timerService.skipTask();
                        _audioController.audioPlayer.close();
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 31),
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(19),
                          color: const Color(0xff592F72),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Finish meditating'.tr,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(
                    flex: 3,
                  ),
                  // if (!widget.isSilence) ...[
                  //   Obx(
                  //     () {
                  //       if (_audioController != null &&
                  //           _audioController.isAudioLoading.value &&
                  //           !_audioController.isPlaylistAudioCached) {
                  //         return buildAudioLoading();
                  //       } else {
                  //         return buildPlayerControls(timerService);
                  //       }
                  //     },
                  //   ),
                  // ],
                  const Spacer(),
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
    // _audioController.dispose();
  }
}

class ControlButton extends StatelessWidget {
  const ControlButton({
    Key key,
    this.img,
    this.imgW,
    this.imgH,
    this.onClick,
  }) : super(key: key);
  final String img;
  final double imgW;
  final double imgH;
  final VoidCallback onClick;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        width: 54,
        margin: const EdgeInsets.symmetric(horizontal: 6.5),
        height: 54,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: menuState == MenuState.NIGT
              ? const Color(0xffFAF5FF)
              : Colors.white.withOpacity(.56),
        ),
        alignment: Alignment.center,
        child: Image.asset(
          img,
          width: imgW,
          height: imgH,
        ),
      ),
    );
  }
}



                    // removed from 151 - 184 lines
                    // Container(
                    //   width: Get.width * 0.8,
                    //   alignment: Alignment.center,
                    //   color: Colors.red,
                    //   child: Obx(
                    //     () {
                    //       var duration =
                    //           _audioController?.meditationTrackDuration?.value;
                    //       return Row(
                    //         children: [
                    //           if (duration != null)
                    //             Text(
                    //               printDuration(
                    //                   _audioController.durationPosition.value,
                    //                   h: false),
                    //             ),
                    //           const SizedBox(width: 10),
                    //           // Flexible(
                    //           //   child: LinearProgressIndicator(value: _audioController.percentDuration.value),
                    //           // ),
                    //           // const SizedBox(width: 10),
                    //           // if (duration != null) ...[
                    //           //   Text(
                    //           //     printDuration(
                    //           //       duration,
                    //           //       h: false,
                    //           //     ),
                    //           //   ),
                    //           // ]
                    //         ],
                    //       );
                    //     },
                    //   ),
                    // ),
              // removed from 125 - 162 lines  
              // Obx(
              //   () => _audioController.withBgSound.value
              //       ? Positioned(
              //           top: Get.height * .20,
              //           left: 20,
              //           child: Row(
              //             children: [
              //               Column(
              //                 children: [
              //                   Icon(Icons.volume_up, color: Colors.black45),
              //                   RotatedBox(
              //                     quarterTurns: -1,
              //                     child: SizedBox(
              //                       width: Get.height * .33,
              //                       child: Obx(() => Slider(
              //                             value: _audioController.bgAudioPlayer.value.volume,
              //                             min: 0,
              //                             max: 1,
              //                             onChanged: _audioController.changeBgValume,
              //                           )),
              //                     ),
              //                   ),
              //                   Icon(Icons.volume_off, color: Colors.black45),
              //                 ],
              //               ),
              //               GestureDetector(
              //                   onTap: () {
              //                     _audioController.currentPage.value = MenuItems.music;
              //                     _audioController.bgAudioPlayer?.value?.pause();
              //                     _audioController.pause();
              //                     Get.to(MeditationAudioPage(fromTimerPage: true, withBgSound: true));
              //                   },
              //                   child: Icon(Icons.library_music, color: Colors.black54)),
              //             ],
              //           ),
              //         )
              //       : SizedBox(),
              // ),