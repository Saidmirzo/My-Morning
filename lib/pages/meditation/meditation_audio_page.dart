import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/features/meditation_audio/presentation/dialogs/audio_meditation_favorite.dart';
import 'package:morningmagic/features/meditation_audio/presentation/dialogs/music_meditation_dialog.dart';
import 'package:morningmagic/pages/meditation/components/menu.dart';
import 'package:morningmagic/services/analitics/all.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

import '../../features/meditation_audio/data/repositories/audio_repository_impl.dart';
import '../../features/meditation_audio/presentation/controller/meditation_audio_controller.dart';
import '../../features/meditation_audio/presentation/dialogs/audio_meditation_dialog.dart';
import '../../resources/colors.dart';
import '../../widgets/primary_circle_button.dart';
import 'controllers/menu_controller.dart';
import 'timer/meditation_timer_page.dart';

class MeditationAudioPage extends StatefulWidget {
  final bool fromTimerPage;

  const MeditationAudioPage({Key key, this.fromTimerPage = false})
      : super(key: key);

  @override
  _MeditationAudioPageState createState() => _MeditationAudioPageState();
}

class _MeditationAudioPageState extends State<MeditationAudioPage> {
  AudioMenuController cMenu;
  MediationAudioController cAudio;

  @override
  void initState() {
    cMenu = Get.put(AudioMenuController());
    cAudio =
        Get.put(MediationAudioController(repository: AudioRepositoryImpl()));
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
                    child: Obx(() {
                      String path = 'assets/images/meditation';
                      String bg = cMenu.currentPage.value == MenuItems.music
                          ? '$path/audio_bg1.png'
                          : cMenu.currentPage.value == MenuItems.sounds
                              ? '$path/audio_bg2.png'
                              : '$path/audio_bg3.png';
                      return Image.asset(bg,
                          width: Get.width, fit: BoxFit.cover);
                    })),
                Column(
                  children: <Widget>[
                    SizedBox(height: Get.height * 0.05),
                    Row(
                      children: [
                        CupertinoButton(
                            child: Icon(Icons.arrow_back, color: Colors.white),
                            onPressed: () async {
                              cAudio.initializeMeditationAudio(
                                  autoplay: false, fromDialog: true);
                              Get.back();
                            }),
                        Spacer(),
                      ],
                    ),
                    SizedBox(height: Get.height * 0.02),
                    PrimaryCircleButton(
                        size: 54,
                        icon:
                            Icon(Icons.arrow_forward, color: AppColors.primary),
                        onPressed: () {
                          if (widget.fromTimerPage) {
                            cAudio.initializeMeditationAudio(
                                autoplay: false, fromDialog: true);
                            Get.back();
                          } else {
                            Get.to(MeditationTimerPage(fromAudio: true));
                            appAnalitics.logEvent('first_music_next');
                          }
                        }),
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
                  child: Obx(() {
                    return cMenu == null
                        ? CircularProgressIndicator()
                        : cMenu.currentPage.value == MenuItems.favorite
                            ? AudioMeditationFavoriteContainer()
                            : cMenu.currentPage.value == MenuItems.music
                                ? MusicMeditationContainer()
                                : AudioMeditationContainer();
                  }),
                ),
              );
            },
          ),
          Positioned(
            bottom: 0,
            child: AudioMenu(),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<AudioMenuController>();
    super.dispose();
  }
}
