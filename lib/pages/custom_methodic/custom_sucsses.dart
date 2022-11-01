import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:morningmagic/utils/reordering_util.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:vibration/vibration.dart';
import '../../../../resources/colors.dart';
import '../../../../widgets/primary_circle_button.dart';

class CastomSuccessPage extends StatefulWidget {
  final bool fromHomeMenu;
  final double percentValue;
  int pageid;

  CastomSuccessPage({Key key, this.fromHomeMenu = false, this.percentValue = 0, this.pageid}) : super(key: key);

  @override
  _CastomSuccessPageState createState() => _CastomSuccessPageState();
}

class _CastomSuccessPageState extends State<CastomSuccessPage> {
  AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _initializeAudioPlayer();
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

  void _initializeAudioPlayer() async {
    _audioPlayer = AudioPlayer();
    await _audioPlayer.setAsset("assets/audios/success.mp3");
    await _audioPlayer.play();
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
          decoration: const BoxDecoration(gradient: AppColors.Bg_Gradient_Timer_Reading),
          child: Stack(
            alignment: Alignment.center,
            children: [
              bg(),
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
    );
  }

  Widget buildButton() {
    return PrimaryCircleButton(
      size: 45,
      icon: const Icon(Icons.arrow_forward, color: AppColors.primary),
      onPressed: _navigateToNextExercise,
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

  Widget buildProgress() {
    return CircularPercentIndicator(
      radius: Get.height * 0.35,
      lineWidth: 27.0,
      reverse: true,
      animation: false,
      percent: 1,
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

  void _navigateToNextExercise() async {
    final _routeValue = await OrderUtil().getRouteById(widget.pageid);
    Get.off(_routeValue);
  }
}
