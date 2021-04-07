import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:morningmagic/resources/styles.dart';
import 'package:morningmagic/services/analitics/all.dart';
import 'package:morningmagic/widgets/primary_circle_button.dart';

import '../../features/meditation_audio/data/repositories/audio_repository_impl.dart';
import '../../features/meditation_audio/presentation/controller/meditation_audio_controller.dart';
import '../../resources/colors.dart';
import 'components/bg.dart';
import 'meditation_audio_page.dart';
import 'timer/meditation_timer_page.dart';

class MeditationPage extends StatefulWidget {
  _MeditationPageState createState() => _MeditationPageState();
}

class _MeditationPageState extends State<MeditationPage> {
  final _audioController =
      Get.put(MediationAudioController(repository: AudioRepositoryImpl()));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.Bg_Gradient_1),
        width: Get.width,
        height: Get.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            bg(),
            Column(
              children: <Widget>[
                SizedBox(height: Get.height * 0.12),
                Text('meditation'.tr, style: AppStyles.treaningTitle),
                SizedBox(height: Get.height * 0.06),
                Text('meditation_title'.tr,
                    style: AppStyles.treaningSubtitle,
                    textAlign: TextAlign.center),
                SizedBox(height: Get.height * 0.06),
                PrimaryCircleButton(
                    size: 54,
                    icon: SvgPicture.asset('assets/images/svg/add_music.svg'),
                    onPressed: () {
                      Get.to(MeditationAudioPage());
                      appAnalitics.logEvent('first_music');
                    }),
                SizedBox(height: Get.height * 0.04),
                PrimaryCircleButton(
                    size: 54,
                    icon: Icon(Icons.arrow_forward, color: AppColors.primary),
                    onPressed: () {
                      Get.to(MeditationTimerPage());
                      appAnalitics.logEvent('first_meditation_start');
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
