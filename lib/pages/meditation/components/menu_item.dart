import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:morningmagic/pages/meditation/controllers/menu_controller.dart';

import '../../../resources/colors.dart';

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String svgPath;
  final String title;
  final int itemIndex;

  const MenuItem(
      {Key key, this.icon, this.title = '', this.itemIndex, this.svgPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    AudioMenuController cMenu = Get.find();
    return Obx(() {
      Color _color = itemIndex == cMenu.currentPage.value
          ? AppColors.primary
          : AppColors.primary.withOpacity(0.4);
      return CupertinoButton(
          padding: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: svgPath != null
                    ? SvgPicture.asset(svgPath, color: _color)
                    : Icon(icon, color: _color),
                onPressed: () => cMenu.changePage(itemIndex),
                color: _color,
              ),
              if (title.isNotEmpty)
                Text(title,
                    style: TextStyle(
                      fontSize: Get.height * 0.015,
                      color: _color,
                      fontWeight: FontWeight.w400,
                    )),
            ],
          ),
          onPressed: () {});
    });
  }
}
