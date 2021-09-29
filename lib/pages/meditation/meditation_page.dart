import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:morningmagic/pages/add_time_page/add_time_period.dart';
import 'package:morningmagic/pages/meditation/meditation_audio_page_night.dart';
import 'package:morningmagic/pages/menu/main_menu.dart';
import 'package:morningmagic/resources/styles.dart';
import 'package:morningmagic/routing/app_routing.dart';
import 'package:morningmagic/routing/timer_page_ids.dart';
import 'package:morningmagic/services/analitics/all.dart';
import 'package:morningmagic/services/timer_service.dart';
import 'package:morningmagic/storage.dart';
import 'package:morningmagic/utils/reordering_util.dart';
import 'package:morningmagic/widgets/primary_circle_button.dart';

import '../../features/meditation_audio/data/repositories/audio_repository_impl.dart';
import '../../features/meditation_audio/presentation/controller/meditation_audio_controller.dart';
import '../../resources/colors.dart';
import 'components/bg.dart';
import 'meditation_audio_page.dart';
import 'timer/meditation_timer_page.dart';

class MeditationPage extends StatefulWidget {
  bool fromHomeMenu;
  MeditationPage({Key key, this.fromHomeMenu = false}) : super(key: key);

  _MeditationPageState createState() => _MeditationPageState();
}

class _MeditationPageState extends State<MeditationPage> {
  @override
  void initState() {
    super.initState();
    Get.put(MediationAudioController(repository: AudioRepositoryImpl()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
            gradient: menuState == MenuState.MORNING
                ? AppColors.Bg_Gradient_1
                : AppColors.gradient_loading_night_bg),
        width: Get.width,
        height: Get.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            menuState == MenuState.MORNING ? bg() : bgNightMeditation(),
            SafeArea(
              bottom: false,
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: PrimaryCircleButton(
                      icon: Icon(Icons.arrow_back, color: AppColors.primary),
                      onPressed: () {
                        if (widget.fromHomeMenu)
                          return AppRouting.navigateToHomeWithClearHistory();
                        OrderUtil()
                            .getPreviousRouteById(TimerPageId.Meditation)
                            .then((value) {
                          Get.off(value);
                        });
                      },
                    ),
                  ),
                  SizedBox(height: Get.height * 0.12),
                  Text('meditation'.tr, style: AppStyles.treaningTitle),
                  SizedBox(height: Get.height * 0.06),
                  Text('meditation_title'.tr,
                      style: AppStyles.treaningSubtitle,
                      textAlign: TextAlign.center),
                  SizedBox(height: Get.height * 0.02),
                  if (menuState == MenuState.MORNING)
                    PrimaryCircleButton(
                        size: 38,
                        icon:
                            SvgPicture.asset('assets/images/svg/add_music.svg'),
                        onPressed: () {
                          Get.to(MeditationAudioPage(
                              fromHomeMenu: widget.fromHomeMenu));
                          appAnalitics.logEvent('first_music');
                        }),
                  SizedBox(height: Get.height * 0.04),
                  PrimaryCircleButton(
                      size: 38,
                      icon: Icon(Icons.arrow_forward, color: AppColors.primary),
                      onPressed: () {
                        if (menuState == MenuState.MORNING)
                          Get.to(MeditationTimerPage(
                              fromHomeMenu: widget.fromHomeMenu));
                        else
                          Get.to(MeditationAudioNightPage(
                            fromTimerPage: false,
                            fromHomeMenu: true,
                          ));
                        appAnalitics.logEvent('first_meditation_start');
                      }),
                  SizedBox(height: Get.height * 0.04),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
