import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/resources/styles.dart';
import 'package:morningmagic/widgets/primary_circle_button.dart';

import '../../resources/colors.dart';
import '../../resources/colors.dart';
import '../timerPage.dart';
import 'components/bg.dart';

class ReadingPage extends StatefulWidget {
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
                  SizedBox(height: Get.height * 0.15),
                  Text('reading'.tr, style: AppStyles.treaningTitle),
                  SizedBox(height: Get.height * 0.05),
                  Text('reading_title'.tr,
                      style: AppStyles.treaningSubtitle,
                      textAlign: TextAlign.center),
                  SizedBox(height: Get.height * 0.1),
                  PrimaryCircleButton(
                      icon: Icon(Icons.arrow_forward, color: AppColors.primary),
                      onPressed: () => Get.to(TimerPage(pageId: 4))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
