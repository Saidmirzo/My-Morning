import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/widgets/animatedButton.dart';
import 'package:morningmagic/widgets/custom_progress_bar/arcProgressBar.dart';
import 'package:vibration/vibration.dart';

class TimerSuccessScreen extends StatefulWidget {
  final VoidCallback onPressed;

  TimerSuccessScreen(this.onPressed);

  @override
  State createState() {
    return TimerSuccessScreenState();
  }
}

class TimerSuccessScreenState extends State<TimerSuccessScreen> {
  AssetsAudioPlayer assetsAudioPlayer;

  @override
  void initState() {
    super.initState();
    assetsAudioPlayer = AssetsAudioPlayer();
    assetsAudioPlayer.open(Audio("assets/audios/success.mp3"));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  Future<void> _asyncMethod() async {
    if (await Vibration.hasVibrator()) {
      Vibration.vibrate();
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (assetsAudioPlayer != null) {
      assetsAudioPlayer.stop();
      assetsAudioPlayer.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.TOP_GRADIENT,
              AppColors.MIDDLE_GRADIENT,
              AppColors.BOTTOM_GRADIENT
            ],
          )),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: ArcProgressBar(
                  text: 'success'.tr(),
                ),
              ),
              Positioned(
                bottom: MediaQuery.of(context).size.height / 5.5,
                child: AnimatedButton(() async {
                  if (assetsAudioPlayer != null) {
                    assetsAudioPlayer.stop();
                    assetsAudioPlayer.dispose();
                  }
                  widget.onPressed();
                }, 'rex', 'continue'.tr(),
                21, null, null),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
