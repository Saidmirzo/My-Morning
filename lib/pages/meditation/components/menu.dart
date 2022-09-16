import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/features/meditation_audio/presentation/controller/meditation_audio_controller.dart';

import 'menu_item.dart' as menu;

class AudioMenu extends StatelessWidget {
  final bool withBgSound;
  MediationAudioController cAudio = Get.find();

  AudioMenu({Key key, this.withBgSound}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.pink.withOpacity(0.1),
              spreadRadius: 10,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30))),
      child: buildMenu(),
    );
  }

  Widget buildMenu() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        menu.MenuItem(
          title: 'music_menu_music'.tr,
          svgPath: 'assets/images/svg/note.svg',
          itemIndex: MenuItems.music,
        ),
        menu.MenuItem(
          title: 'music_menu_sounds'.tr,
          svgPath: 'assets/images/svg/forest.svg',
          itemIndex: MenuItems.sounds,
        ),
        if (!withBgSound)
          menu.MenuItem(
            title: 'music_menu_meditations'.tr,
            svgPath: 'assets/images/svg/yoga.svg',
            itemIndex: MenuItems.yoga,
          ),
        menu.MenuItem(
          title: 'music_menu_favorite'.tr,
          icon: Icons.star,
          itemIndex: MenuItems.favorite,
        ),
      ],
    );
  }
}
