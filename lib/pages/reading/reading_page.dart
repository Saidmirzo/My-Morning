import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/pages/menu/main_menu.dart';
import 'package:morningmagic/pages/reading/timer/timer_page.dart';
import 'package:morningmagic/resources/styles.dart';
import 'package:morningmagic/routing/timer_page_ids.dart';
import 'package:morningmagic/utils/reordering_util.dart';
import 'package:morningmagic/widgets/primary_circle_button.dart';

import '../../resources/colors.dart';
import 'components/bg.dart';

class ReadingPage extends StatefulWidget {
  final bool fromHomeMenu;
  ReadingPage({Key key, this.fromHomeMenu = false}) : super(key: key);

  _ReadingPageState createState() => _ReadingPageState();
}

class _ReadingPageState extends State<ReadingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.Bg_Gradient_2),
        width: Get.width,
        height: Get.height,
        child: SafeArea(
          bottom: false,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              bg(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: PrimaryCircleButton(
                      icon: Icon(Icons.arrow_back, color: AppColors.primary),
                      onPressed: () {
                        if (widget.fromHomeMenu)
                          return Get.off(MainMenuPage(), opaque: true);
                        OrderUtil()
                            .getPreviousRouteById(TimerPageId.Reading)
                            .then((value) {
                          Get.off(value);
                        });
                      },
                    ),
                  ),
                  SizedBox(height: Get.height * 0.15),
                  Text('reading'.tr, style: AppStyles.treaningTitle),
                  SizedBox(height: Get.height * 0.05),
                  Text('reading_title'.tr,
                      style: AppStyles.treaningSubtitle,
                      textAlign: TextAlign.center),
                  SizedBox(height: Get.height * 0.1),
                  PrimaryCircleButton(
                      icon: Icon(Icons.arrow_forward, color: AppColors.primary),
                      onPressed: () => Get.to(
                          ReadingTimerPage(fromHomeMenu: widget.fromHomeMenu))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
