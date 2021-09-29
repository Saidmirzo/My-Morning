import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/features/meditation_audio/presentation/controller/meditation_audio_controller.dart';

import 'menu_item.dart';

class AudioMenuNight extends StatelessWidget {
  final bool withBgSound;
  MediationAudioController cAudio = Get.find();

  AudioMenuNight({Key key, this.withBgSound}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.1),
              spreadRadius: 10,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          color: Color(0xFF040826),
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      child: buildMenu(),
    );
  }

  Widget buildMenu() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        MenuItem(
          // title: 'music_menu_music'.tr,
          svgPath: 'assets/images/meditation/meditation_icon_menu.svg',
          itemIndex: MenuItems.meditationNight,
        ),
        MenuItem(
          // title: 'music_menu_sounds'.tr,
          svgPath: 'assets/images/meditation/favorite_icon_menu.svg',
          itemIndex: MenuItems.favorite,
        ),
      ],
    );
  }
}
