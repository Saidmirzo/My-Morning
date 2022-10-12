import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/features/meditation_audio/presentation/dialogs/audio_meditation_favorite.dart';
import 'package:morningmagic/features/meditation_audio/presentation/dialogs/music_meditation_dialog.dart';
import 'package:morningmagic/features/meditation_audio/presentation/dialogs/yoga_meditation_dialog.dart';
import 'package:morningmagic/pages/meditation/components/menu_night.dart';
import 'package:morningmagic/pages/meditation/timer/meditation_timer_page.dart';
import 'package:morningmagic/services/analitics/all.dart';
import 'package:morningmagic/widgets/primary_circle_button.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import '../../features/meditation_audio/data/repositories/audio_repository_impl.dart';
import '../../features/meditation_audio/presentation/controller/meditation_audio_controller.dart';
import '../../features/meditation_audio/presentation/dialogs/audio_meditation_dialog.dart';
import '../../resources/colors.dart';

class MeditationAudioNightPage extends StatefulWidget {
  final bool fromTimerPage;
  final bool fromHomeMenu;
  final bool withBgSound;

  const MeditationAudioNightPage(
      {Key key,
      this.fromTimerPage = false,
      this.fromHomeMenu = false,
      this.withBgSound = false})
      : super(key: key);

  @override
  _MeditationAudioNightPageState createState() =>
      _MeditationAudioNightPageState();
}

class _MeditationAudioNightPageState extends State<MeditationAudioNightPage> {
  MediationAudioController cAudio;

  @override
  void initState() {
    cAudio =
        Get.put(MediationAudioController(repository: AudioRepositoryImpl()));
    print('withBgSound: ${cAudio.withBgSound}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SlidingSheet(
            color: const Color(0xFF040826),
            elevation: 8,
            cornerRadius: 16,
            snapSpec: const SnapSpec(
              // Enable snapping. This is true by default.
              snap: true,
              // Set custom snapping points.
              snappings: [0.7, 1.0],
              // Define to what the snappings relate to. In this case,
              // the total available space that the sheet can expand to.
              positioning: SnapPositioning.relativeToAvailableSpace,
            ),
            body: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                    top: 0,
                    child: Image.asset('assets/images/meditation/audio_bg3.png',
                        width: Get.width, fit: BoxFit.cover)),
                Column(
                  children: <Widget>[
                    SizedBox(height: Get.height * 0.05),
                    Row(
                      children: [
                        CupertinoButton(
                            child: const Icon(Icons.arrow_back,
                                color: AppColors.nightBtnBg),
                            onPressed: () async {
                              cAudio.bfPlayer.value.stop();
                              cAudio.playingIndex.value = -1;
                              cAudio.initializeMeditationAudio(
                                  autoplay: false, fromDialog: true);
                              Get.back();
                            }),
                        const Spacer(),
                      ],
                    ),
                    SizedBox(height: Get.height * 0.02),
                    PrimaryCircleButton(
                        bgColor: AppColors.nightBtnBg,
                        size: 54,
                        icon: const Icon(Icons.arrow_forward,
                            color: Color(0xFF8889B3)),
                        onPressed: () {
                          cAudio.bfPlayer.value.stop();
                          cAudio.playingIndex.value = -1;
                          if (cAudio.currentPage.value == MenuItems.yoga) {
                            cAudio.withBgSound(false);
                          } else {
                            if (!widget.withBgSound) cAudio.bgPlayList?.clear();
                            cAudio.withBgSound(widget.withBgSound);
                          }
                          if (widget.fromTimerPage) {
                            cAudio.initializeMeditationAudio(
                                autoplay: false,
                                fromDialog: true,
                                reinitMainSound: !widget.withBgSound);
                            Get.back();
                          } else {
                            Get.to(MeditationTimerPage(
                                fromAudio: true,
                                fromHomeMenu: widget.fromHomeMenu));
                            appAnalitics.logEvent('first_music_next');
                          }
                        }),
                  ],
                ),
              ],
            ),
            builder: (context, state) {
              return ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: Get.height,
                ),
                child: Container(
                  // height: Get.height,
                  padding: const EdgeInsetsDirectional.only(bottom: 50),
                  child: Obx(() {
                    print(
                        'cAudio.currentPage.value: ${cAudio.currentPage?.value}');
                    return cAudio == null
                        ? const CircularProgressIndicator()
                        : cAudio.currentPage.value == MenuItems.favorite
                            ? const AudioMeditationFavoriteContainer()
                            : cAudio.currentPage.value == MenuItems.music
                                ? MusicMeditationContainer(
                                    withBgSound: widget.withBgSound)
                                : cAudio.currentPage.value ==
                                        MenuItems.meditationNight
                                    // ? YogaMeditationNightContainer()
                                    // : cAudio.currentPage.value == MenuItems.yoga
                                    ? AudioMeditationContainer(
                                        withBgSound: widget.withBgSound)
                                    : const YogaMeditationContainer();
                  }),
                ),
              );
            },
          ),
          Positioned(
            bottom: 0,
            child: AudioMenuNight(withBgSound: widget.withBgSound),
          )
        ],
      ),
    );
  }

  void openMeditation() {
    cAudio.bfPlayer.value.stop();
    cAudio.playingIndex.value = -1;
    if (cAudio.currentPage.value == MenuItems.yoga) {
      cAudio.withBgSound(true);
    } else {
      if (!widget.withBgSound) cAudio.bgPlayList?.clear();
      cAudio.withBgSound(widget.withBgSound);
    }
    if (widget.fromTimerPage) {
      cAudio.initializeMeditationAudio(
          autoplay: false,
          fromDialog: true,
          reinitMainSound: !widget.withBgSound);
      Get.back();
    } else {
      Get.to(MeditationTimerPage(
          fromAudio: true, fromHomeMenu: widget.fromHomeMenu));
      appAnalitics.logEvent('first_music_next');
    }
  }
}
