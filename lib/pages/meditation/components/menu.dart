import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'menu_item.dart';

class MenuItems {
  static const int music = 1;
  static const int sounds = 2;
  static const int favorite = 3;
}

class AudioMenu extends StatelessWidget {
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
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      child: buildMenu(),
    );
  }

  Widget buildMenu() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        MenuItem(
          title: 'music_menu_music'.tr,
          svgPath: 'assets/images/svg/note.svg',
          itemIndex: MenuItems.music,
        ),
        MenuItem(
          title: 'music_menu_sounds'.tr,
          svgPath: 'assets/images/svg/forest.svg',
          itemIndex: MenuItems.sounds,
        ),
        MenuItem(
          title: 'music_menu_favorite'.tr,
          icon: Icons.star,
          itemIndex: MenuItems.favorite,
        ),
      ],
    );
  }
}
