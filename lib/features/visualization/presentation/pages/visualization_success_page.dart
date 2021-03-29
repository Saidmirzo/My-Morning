import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:just_audio/just_audio.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/app_gradient_container.dart';
import 'package:morningmagic/features/visualization/presentation/controller/visualization_controller.dart';
import 'package:morningmagic/utils/reordering_util.dart';
import 'package:morningmagic/widgets/animatedButton.dart';
import 'package:morningmagic/widgets/custom_progress_bar/arcProgressBar.dart';
import 'package:vibration/vibration.dart';

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
    return Scaffold(
      body: AppGradientContainer(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              child: ArcProgressBar(
                text: 'success'.tr,
              ),
            ),
            SizedBox(
              height: 36,
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height / 5.5,
              child: AnimatedButton(
                  _navigateToNextExercise, 'continue'.tr, 21, null, null),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToNextExercise() async {
    final _routeValue = await OrderUtil().getRouteById(5);
    Navigator.pushReplacement(context, _routeValue);
  }
}
