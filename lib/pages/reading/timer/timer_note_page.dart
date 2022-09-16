import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:morningmagic/pages/reading/timer/components/customInputNextColumn.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/storage.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:vibration/vibration.dart';
import '../../../resources/colors.dart';

class TimerInputSuccessScreen extends StatefulWidget {
  final int passedSec;
  final bool isSkip;
  final bool fromHomeMenu;
  final double procent;

  const TimerInputSuccessScreen(this.passedSec, this.isSkip, this.procent,
      {this.fromHomeMenu = false});

  @override
  State createState() {
    return TimerInputSuccessScreenState();
  }
}

class TimerInputSuccessScreenState extends State<TimerInputSuccessScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  Future<void> _asyncMethod() async {
    if (await Vibration.hasVibrator()) {
      Vibration.vibrate();
    }
    await _audioPlayer.setAsset("assets/audios/success.mp3");
    _audioPlayer.play();
  }

  @override
  void dispose() {
    super.dispose();
    dispAudio();
  }

  dispAudio() async {
    if (_audioPlayer != null) {
      await _audioPlayer.stop();
      await _audioPlayer.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Scaffold(
        body: Container(
          width: Get.width,
          height: Get.height,
          decoration: BoxDecoration(
              gradient: menuState == MenuState.NIGT
                  ? AppColors.gradient_loading_night_bg
                  : AppColors.Bg_Gradient_Timer_Reading),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              bg(menuState == MenuState.NIGT
                  ? 'assets/images/reading_night/clouds.png'
                  : 'assets/images/timer/clouds_timer.png'),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildProgress(context),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: Get.height / 17),
                    child: InputTextColumn(
                      () {
                        dispAudio();
                      },
                      widget.passedSec,
                      widget.isSkip,
                      fromHomeMenu: widget.fromHomeMenu,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProgress(BuildContext context) {
    return CircularPercentIndicator(
      radius: Get.height * 0.25,
      lineWidth: 18.0,
      reverse: true,
      animation: false,
      percent: widget.procent,
      center: Text(
        'success'.tr,
        style: TextStyle(
            fontSize: Get.height * 0.04,
            fontStyle: FontStyle.normal,
            color: Colors.white,
            fontWeight: FontWeight.w600),
      ),
      circularStrokeCap: CircularStrokeCap.round,
      linearGradient: AppColors.Progress_Gradient_Timer_Reading,
      backgroundColor: Colors.white,
    );
  }

  Positioned bg(String pathImage) {
    return Positioned(
      bottom: 0,
      child: SizedBox(
        width: Get.width,
        child: Image.asset(
          pathImage,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget bgNight() {
    return Stack(
      children: [
        Positioned(
            bottom: 0,
            child: Image.asset('assets/images/reading_night/clouds.png',
                width: Get.width, fit: BoxFit.cover)),
        Positioned(
          bottom: 0,
          child: Image.asset('assets/images/reading/mountain1.png',
              width: Get.width, fit: BoxFit.cover),
        ),
        Positioned(
          bottom: 0,
          child: Image.asset('assets/images/reading/mountain2.png',
              width: Get.width, fit: BoxFit.cover),
        ),
        Positioned(
            bottom: 0,
            child: Image.asset('assets/images/reading_night/main.png',
                width: Get.width, fit: BoxFit.cover)),
      ],
    );
  }

  Future<bool> _onWillPop() async {
    dispAudio();
    return true;
  }
}
