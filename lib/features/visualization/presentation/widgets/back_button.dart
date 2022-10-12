import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:morningmagic/dialog/back_to_main_menu_dialog.dart';
import 'package:morningmagic/pages/menu/main_menu.dart';

class VisualizationBackButton extends StatelessWidget {
  final Color color;

  const VisualizationBackButton({Key key, this.color = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 36.0, left: 8),
      child: IconButton(
        icon: Icon(
          Icons.arrow_back_rounded,
          size: 36,
          color: color,
        ),
        onPressed: () {
          if (isComplex) {
            showDialog(
              context: context,
              builder: (context) => const BackToMainMenuDialog(),
            );
          } else {
            Get.to(const MainMenuPage());
          }
        },
      ),
    );
  }
}
