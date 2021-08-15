import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:just_audio/just_audio.dart';
import 'package:morningmagic/features/fitness/presentation/controller/fitness_controller.dart';
import 'package:morningmagic/features/fitness/presentation/controller/timer_controller.dart';
import 'package:morningmagic/pages/progress/progress_page.dart';
import 'package:morningmagic/utils/reordering_util.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:vibration/vibration.dart';

import '../../../../resources/colors.dart';
import '../../../../widgets/primary_circle_button.dart';

class FitnessSuccessPage extends StatefulWidget {
  final int countProgram;

  const FitnessSuccessPage({Key key, this.countProgram}) : super(key: key);

  @override
  State createState() {
    return FitnessSuccessPageState();
  }
}

class FitnessSuccessPageState extends State<FitnessSuccessPage> {
  AudioPlayer _audioPlayer = AudioPlayer();
  DateTime dateTime = DateTime.now();
  FitnessController controller = Get.find();
  int count;

  @override
  void initState() {
    super.initState();
    Get.delete<TimerFitnesController>();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _vibrate();
      await _audioPlayer.setAsset("assets/audios/success.mp3");
      await _audioPlayer.play();
    });
  }

  @override
  void dispose() {
    if (_audioPlayer != null) {
      _audioPlayer.stop();
      _audioPlayer.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final _fitnessController = Get.find<FitnessController>();
        _fitnessController.step = 0;
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
      onPressed: _continueClicked,
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

  void _continueClicked() async {
    Widget _routeValue;
    print('fromHome: ${controller.fromHomeMenu}');
    if (controller.fromHomeMenu) {
      _routeValue = ProgressPage();
    } else {
      _routeValue = await OrderUtil().getRouteById(2);
    }
    Get.delete<FitnessController>();
    Get.off(_routeValue, opaque: true);
  }

  Future<void> _vibrate() async {
    if (await Vibration.hasVibrator()) {
      Vibration.vibrate();
    }
  }
}
