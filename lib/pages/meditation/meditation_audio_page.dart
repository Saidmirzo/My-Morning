import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:morningmagic/pages/meditation/components/menu.dart';
import 'package:morningmagic/widgets/primary_square_button.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

import '../../features/meditation_audio/presentation/dialogs/audio_meditation_dialog.dart';
import '../../resources/colors.dart';
import '../../widgets/primary_circle_button.dart';
import '../timerPage.dart';
import 'controllers/menu_controller.dart';

class MeditationAudioPage extends StatefulWidget {
  @override
  _MeditationAudioPageState createState() => _MeditationAudioPageState();
}

class _MeditationAudioPageState extends State<MeditationAudioPage> {
  final cMenu = Get.put(AudioMenuController());
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
                            onPressed: () => Get.back()),
                        Spacer(),
                        buildDownloadButton(),
                      ],
                    ),
                    SizedBox(height: Get.height * 0.03),
                    PrimaryCircleButton(
                        size: 54,
                        icon:
                            Icon(Icons.arrow_forward, color: AppColors.primary),
                        onPressed: () => Get.to(TimerPage(pageId: 1))),
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
                  child: AudioMeditationContainer(),
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

  Widget buildDownloadButton() {
    return CupertinoButton(
      onPressed: () {},
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(7)),
        padding: const EdgeInsets.all(5),
        child: SvgPicture.asset('assets/images/svg/download.svg',
            color: AppColors.primary),
      ),
    );
  }
}
