import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/storage.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:stack_appodeal_flutter/stack_appodeal_flutter.dart';
import 'package:vibration/vibration.dart';

import '../../widgets/primary_circle_button.dart';

class TimerSuccessScreen extends StatefulWidget {
  final VoidCallback onPressed;
  final int minutes;
  final bool isFinal;
  final double procent;

  const TimerSuccessScreen(this.onPressed, this.minutes, this.isFinal, this.procent);

  @override
  State createState() {
    return TimerSuccessScreenState();
  }
}

class TimerSuccessScreenState extends State<TimerSuccessScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  DateTime dateTime = DateTime.now();
  int count;

  @override
  void initState() {
    super.initState();
    print(widget.minutes);
    print(widget.isFinal);
    print('init Screen timer success');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  Future<void> _asyncMethod() async {
    if (await Vibration.hasVibrator()) {
      Vibration.vibrate();
    }
    await _audioPlayer.setAsset("assets/audios/success.mp3");
    await _audioPlayer.play();
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
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Center(
          child: Container(
            width: Get.width,
            height: Get.height,
            decoration: BoxDecoration(
                gradient: menuState == MenuState.MORNING
                    ? AppColors.Bg_Gradient_Timer_Reading
                    : AppColors.gradient_loading_night_bg),
            child: Stack(
              alignment: Alignment.center,
              children: [
                bg(),
                if (menuState == MenuState.NIGT) mn1(),
                if (menuState == MenuState.NIGT) mn2(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildProgress(),
                    const SizedBox(height: 20),
                    const SizedBox(height: 50),
                    buildButton(),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildButton() {
    return PrimaryCircleButton(
      size: 45,
      icon: const Icon(Icons.arrow_forward, color: AppColors.primary),
      onPressed: () async {
        if (_audioPlayer != null) {
          _audioPlayer.stop();
          _audioPlayer.dispose();
        }
        if (widget.isFinal && !billingService.isVip.value) {
          await Appodeal.show(AppodealAdType.Interstitial, "buildButton");
        }
        widget.onPressed();
      },
    );
  }

  Positioned bg() {
    return Positioned(
      bottom: 0,
      child: SizedBox(
        width: Get.width,
        child: Image.asset(
          'assets/images/timer/clouds_timer.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Positioned mn1() {
    return Positioned(
      bottom: 0,
      child: Image.asset('assets/images/meditation/mountain1_night.png', width: Get.width, fit: BoxFit.cover),
    );
  }

  Positioned mn2() {
    return Positioned(
      bottom: 0,
      child: Image.asset('assets/images/meditation/mountain2_night.png', width: Get.width, fit: BoxFit.cover),
    );
  }

  Widget buildProgress() {
    return CircularPercentIndicator(
      radius: Get.height * 0.2,
      lineWidth: 27.0,
      reverse: true,
      animation: false,
      percent: widget.isFinal ? 1 : widget.procent,
      center: Text(
        'success'.tr,
        style: TextStyle(
            fontSize: Get.height * 0.04, fontStyle: FontStyle.normal, color: Colors.white, fontWeight: FontWeight.w600),
      ),
      circularStrokeCap: CircularStrokeCap.round,
      linearGradient: AppColors.Progress_Gradient_Timer_Reading,
      backgroundColor: Colors.white,
    );
  }
}
