import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:morningmagic/features/meditation_audio/data/meditation_audio_data.dart';
import 'package:morningmagic/features/meditation_audio/domain/entities/meditation_audio.dart';
import 'package:morningmagic/resources/styles.dart';
import 'package:morningmagic/routing/app_routing.dart';
import 'package:morningmagic/routing/timer_page_ids.dart';
import 'package:morningmagic/services/analitics/all.dart';
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
  MediationAudioController _audioController;
  List<MeditationAudio> _source = [];

  @override
  void initState() {
    super.initState();
    Get.put(MediationAudioController(repository: AudioRepositoryImpl()));
    _audioController = Get.find();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(gradient: menuState == MenuState.MORNING ? AppColors.Bg_Gradient_1 : AppColors.gradient_loading_night_bg),
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
                        if (widget.fromHomeMenu) return AppRouting.navigateToHomeWithClearHistory();
                        OrderUtil().getPreviousRouteById(TimerPageId.Meditation).then((value) {
                          Get.off(value);
                        });
                      },
                    ),
                  ),
                  SizedBox(height: Get.height * 0.12),
                  Text(
                    'meditation'.tr.toUpperCase(),
                    style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'meditation_title'.tr,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 50),
                  Text(
                    'meditation_select'.tr.toUpperCase(),
                    style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () => Get.to(MeditationTimerPage(fromHomeMenu: widget.fromHomeMenu, isSilence: true)),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            child: Text(
                              'meditation_menu_1'.tr.toUpperCase(),
                              style: AppStyles.treaningSubtitle.copyWith(color: HexColor("#592F72"), fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () => Get.to(MeditationTimerPage(fromHomeMenu: widget.fromHomeMenu)),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            child: Text(
                              'meditation_menu_2'.tr.toUpperCase(),
                              style: AppStyles.treaningSubtitle.copyWith(color: HexColor("#592F72"), fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              _audioController.selectedItemIndex.value = 0;
                              _audioController.bufIdSelected.value = 0;
                              _audioController = Get.find();
                              _source.addAll(Get.locale.languageCode == 'ru' ? meditationAudioData.meditationRuSource : meditationAudioData.meditationEnSource);
                              _audioController.changeAudioSource(_source);
                              _audioController.currentPage.value = MenuItems.yoga;
                              Get.to(MeditationTimerPage(fromHomeMenu: true));
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            child: Text(
                              'meditation_menu_3'.tr.toUpperCase(),
                              style: AppStyles.treaningSubtitle.copyWith(color: HexColor("#592F72"), fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // if (menuState == MenuState.MORNING)
                  //   PrimaryCircleButton(
                  //     size: 38,
                  //     icon: SvgPicture.asset('assets/images/svg/add_music.svg'),
                  //     onPressed: () {
                  //       Get.to(MeditationAudioPage(fromHomeMenu: widget.fromHomeMenu));
                  //       appAnalitics.logEvent('first_music');
                  //     },
                  //   ),
                  // PrimaryCircleButton(
                  //   size: 38,
                  //   icon: Icon(Icons.arrow_forward, color: AppColors.primary),
                  //   onPressed: () {
                  //     if (menuState == MenuState.MORNING)
                  //       Get.to(MeditationTimerPage(fromHomeMenu: widget.fromHomeMenu));
                  //     else
                  //       Get.to(MeditationAudioNightPage(
                  //         fromTimerPage: false,
                  //         fromHomeMenu: true,
                  //       ));
                  //     appAnalitics.logEvent('first_meditation_start');
                  //   },
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
