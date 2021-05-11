import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:just_audio/just_audio.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/app_gradient_container.dart';
import 'package:morningmagic/features/visualization/presentation/controller/visualization_controller.dart';
import 'package:morningmagic/utils/reordering_util.dart';
import 'package:morningmagic/widgets/animatedButton.dart';
import 'package:morningmagic/widgets/custom_progress_bar/arcProgressBar.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:vibration/vibration.dart';

import '../../../../resources/colors.dart';
import '../../../../widgets/primary_circle_button.dart';

class VisualizationSuccessPage extends StatefulWidget {
  @override
  _VisualizationSuccessPageState createState() =>
      _VisualizationSuccessPageState();
}

class _VisualizationSuccessPageState extends State<VisualizationSuccessPage> {
  AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    Get.delete<VisualizationController>();
    _initializeAudioPlayer();
  }

  @override
  void dispose() {
    if (_audioPlayer != null) {
      _audioPlayer.stop();
      _audioPlayer.dispose();
    }
    super.dispose();
  }

  void _initializeAudioPlayer() {
    _audioPlayer = AudioPlayer();
    _audioPlayer.setAsset("assets/audios/success.mp3");
    _audioPlayer.play();
  }

  Future<void> _vibrate() async {
    if (await Vibration.hasVibrator()) {
      Vibration.vibrate();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        body: Container(
          width: Get.width,
          height: Get.height,
          decoration:
              BoxDecoration(gradient: AppColors.Bg_Gradient_Timer_Reading),
          child: Stack(
            alignment: Alignment.center,
            children: [
              bg(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildProgress(),
                  SizedBox(height: 20),
                  const SizedBox(height: 50),
                  buildButton(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButton() {
    return PrimaryCircleButton(
      size: 45,
      icon: Icon(Icons.arrow_forward, color: AppColors.primary),
      onPressed: _navigateToNextExercise,
    );
  }

  Positioned bg() {
    return Positioned(
      bottom: 0,
      child: Container(
        width: Get.width,
        child: Image.asset(
          'assets/images/timer/clouds_timer.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget buildProgress() {
    return CircularPercentIndicator(
      radius: Get.height * 0.35,
      lineWidth: 27.0,
      reverse: true,
      animation: false,
      percent: 0.4,
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

  void _navigateToNextExercise() async {
    final _routeValue = await OrderUtil().getRouteById(5);
    Get.off(_routeValue);
  }
}
