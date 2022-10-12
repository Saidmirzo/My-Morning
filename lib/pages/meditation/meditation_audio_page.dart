import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/features/meditation_audio/presentation/dialogs/music_meditation_dialog.dart';
import 'package:morningmagic/features/meditation_audio/presentation/dialogs/yoga_meditation_dialog.dart';
import 'package:morningmagic/pages/meditation/timer/meditation_timer_page.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import '../../features/meditation_audio/data/repositories/audio_repository_impl.dart';
import '../../features/meditation_audio/presentation/controller/meditation_audio_controller.dart';
import '../../services/analitics/all.dart';
import '../../services/timer_service.dart';

class MeditationAudioPage extends StatefulWidget {
  final bool fromTimerPage;
  final bool fromHomeMenu;
  final bool withBgSound;
  final bool isMeditation;
  final TimerService timerService;

  const MeditationAudioPage({
    Key key,
    this.fromTimerPage = false,
    this.fromHomeMenu = false,
    this.withBgSound = false,
    this.isMeditation = false,
    this.timerService,
  }) : super(key: key);

  @override
  _MeditationAudioPageState createState() => _MeditationAudioPageState();
}

class _MeditationAudioPageState extends State<MeditationAudioPage> {
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
                  child: Image.asset(
                    widget.isMeditation
                        ? 'assets/images/meditation/audio_bg3.png'
                        : 'assets/images/meditation/audio_bg2.png',
                    width: Get.width,
                    fit: BoxFit.cover,
                  ),
                  // child: Obx(
                  //   () {
                  //     String path = 'assets/images/meditation';
                  //     String bg = widget.isMeditation ? '$path/audio_bg3.png' : '$path/audio_bg2.png';
                  //         // ? '$path/audio_bg1.png'
                  //         // : cAudio.currentPage.value == MenuItems.sounds
                  //         //     ? '$path/audio_bg2.png'
                  //         //     : cAudio.currentPage.value == MenuItems.yoga
                  //         //         ? '$path/audio_bg3.png'
                  //         //         : '$path/audio_bg4.png';
                  //     return Image.asset(
                  //       widget.isMeditation ? '$path/audio_bg3.png' : '$path/audio_bg2.png',
                  //       width: Get.width,
                  //       fit: BoxFit.cover,
                  //     );
                  //   },
                  // ),
                ),
                Column(
                  children: <Widget>[
                    SizedBox(height: Get.height * 0.05),
                    Row(
                      children: [
                        CupertinoButton(
                          child: const Icon(Icons.west,
                              size: 30, color: Colors.white),
                          onPressed: () {
                            Get.back();
                            appAnalitics.logEvent('first_music_next');
                          },
                        ),
                        const Spacer(),
                      ],
                    ),
                    SizedBox(height: Get.height * 0.02),
                    // PrimaryCircleButton(
                    //   size: 54,
                    //   icon: Icon(Icons.arrow_forward, color: AppColors.primary),
                    //   onPressed: () {
                    // cAudio.bfPlayer.value.stop();
                    // cAudio.playingIndex.value = -1;
                    // if (cAudio.currentPage.value == MenuItems.yoga) {
                    //   cAudio.withBgSound(true);
                    // } else {
                    //   if (!widget.withBgSound) cAudio.bgPlayList?.clear();
                    //   cAudio.withBgSound(widget.withBgSound);
                    // }
                    // if (widget.fromTimerPage) {
                    //   cAudio.initializeMeditationAudio(autoplay: false, fromDialog: true, reinitMainSound: !widget.withBgSound);
                    //   Get.back();
                    // } else {
                    //   Get.to(MeditationTimerPage(fromAudio: true, fromHomeMenu: widget.fromHomeMenu));
                    //   appAnalitics.logEvent('first_music_next');
                    // }
                    //   },
                    // ),
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
                  child: cAudio == null
                      ? const CircularProgressIndicator()
                      : widget.isMeditation
                          ? YogaMeditationContainer(
                              timerService: widget.timerService)
                          : MusicMeditationContainer(
                              timerService: widget.timerService),
                  // child: Obx(
                  //   () {
                  //     return cAudio == null ? const CircularProgressIndicator() : widget.isMeditation ? YogaMeditationContainer() : const MusicMeditationContainer();
                  //     // return cAudio == null
                  //     //     ? const CircularProgressIndicator()
                  //     //     : cAudio.currentPage.value == MenuItems.favorite
                  //     //         ? AudioMeditationFavoriteContainer()
                  //     //         : cAudio.currentPage.value == MenuItems.music
                  //     //             ? MusicMeditationContainer(
                  //     //                 withBgSound: widget.withBgSound,
                  //     //               )
                  //     //             : cAudio.currentPage.value == MenuItems.yoga
                  //     //                 ? YogaMeditationContainer()
                  //     //                 : AudioMeditationContainer(
                  //     //                     withBgSound: widget.withBgSound,
                  //     //                   );
                  //   },
                  // ),
                ),
              );
            },
          ),
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
      Get.to(() => MeditationTimerPage(
          fromAudio: true, fromHomeMenu: widget.fromHomeMenu));
      appAnalitics.logEvent('first_music_next');
    }
  }
}
