import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/features/meditation_audio/presentation/dialogs/audio_meditation_favorite.dart';
import 'package:morningmagic/features/meditation_audio/presentation/dialogs/music_meditation_dialog.dart';
import 'package:morningmagic/features/meditation_audio/presentation/dialogs/yoga_meditation_dialog.dart';
import 'package:morningmagic/pages/meditation/components/menu.dart';
import 'package:morningmagic/services/analitics/all.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import '../../features/meditation_audio/data/repositories/audio_repository_impl.dart';
import '../../features/meditation_audio/presentation/controller/meditation_audio_controller.dart';
import '../../features/meditation_audio/presentation/dialogs/audio_meditation_dialog.dart';
import 'timer/meditation_timer_page.dart';

class MeditationAudioPage extends StatefulWidget {
  final bool fromTimerPage;
  final bool fromHomeMenu;
  final bool withBgSound;

  const MeditationAudioPage({Key key, this.fromTimerPage = false, this.fromHomeMenu = false, this.withBgSound = false}) : super(key: key);

  @override
  _MeditationAudioPageState createState() => _MeditationAudioPageState();
}

class _MeditationAudioPageState extends State<MeditationAudioPage> {
  MediationAudioController cAudio;

  @override
  void initState() {
    cAudio = Get.put(MediationAudioController(repository: AudioRepositoryImpl()));
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
            snapSpec: SnapSpec(
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
                  child: Obx(
                    () {
                      String path = 'assets/images/meditation';
                      String bg = cAudio.currentPage.value == MenuItems.music
                          ? '$path/audio_bg1.png'
                          : cAudio.currentPage.value == MenuItems.sounds
                              ? '$path/audio_bg2.png'
                              : cAudio.currentPage.value == MenuItems.yoga
                                  ? '$path/audio_bg3.png'
                                  : '$path/audio_bg4.png';
                      return Image.asset(bg, width: Get.width, fit: BoxFit.cover);
                    },
                  ),
                ),
                Column(
                  children: <Widget>[
                    SizedBox(height: Get.height * 0.05),
                    Row(
                      children: [
                        CupertinoButton(
                          child: Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () async {
                            cAudio.bfPlayer.value.stop();
                            cAudio.playingIndex.value = -1;
                            cAudio.initializeMeditationAudio(autoplay: false, fromDialog: true);
                            Get.back();
                          },
                        ),
                        Spacer(),
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
                constraints: new BoxConstraints(
                  minHeight: Get.height,
                ),
                child: Container(
                  // height: Get.height,
                  padding: const EdgeInsetsDirectional.only(bottom: 50),
                  child: Obx(
                    () {
                      print('cAudio.currentPage.value: ${cAudio.currentPage?.value}');
                      return cAudio == null
                          ? CircularProgressIndicator()
                          : cAudio.currentPage.value == MenuItems.favorite
                              ? AudioMeditationFavoriteContainer()
                              : cAudio.currentPage.value == MenuItems.music
                                  ? MusicMeditationContainer(withBgSound: widget.withBgSound)
                                  : cAudio.currentPage.value == MenuItems.yoga
                                      ? YogaMeditationContainer()
                                      : AudioMeditationContainer(withBgSound: widget.withBgSound);
                    },
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 0,
            child: AudioMenu(withBgSound: widget.withBgSound),
          )
        ],
      ),
    );
  }

  // void openMeditation() {
  //   cAudio.bfPlayer.value.stop();
  //   cAudio.playingIndex.value = -1;
  //   if (cAudio.currentPage.value == MenuItems.yoga) {
  //     cAudio.withBgSound(true);
  //   } else {
  //     if (!widget.withBgSound) cAudio.bgPlayList?.clear();
  //     cAudio.withBgSound(widget.withBgSound);
  //   }
  //   if (widget.fromTimerPage) {
  //     cAudio.initializeMeditationAudio(autoplay: false, fromDialog: true, reinitMainSound: !widget.withBgSound);
  //     Get.back();
  //   } else {
  //     Get.to(MeditationTimerPage(fromAudio: true, fromHomeMenu: widget.fromHomeMenu));
  //     appAnalitics.logEvent('first_music_next');
  //   }
  // }
}
