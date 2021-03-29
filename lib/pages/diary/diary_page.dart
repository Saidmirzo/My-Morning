import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/resources/styles.dart';
import 'package:morningmagic/widgets/primary_button.dart';

import '../../pages/screenNote.dart';
import '../../pages/success/screenTimerRecordSuccess.dart';
import '../../resources/colors.dart';
import 'components/bg.dart';

class DiaryPage extends StatefulWidget {
  _DiaryPageState createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.Bg_Gradient_3),
        child: SafeArea(
          bottom: false,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              bg(),
              Column(
                children: <Widget>[
                  SizedBox(height: Get.height * 0.15),
                  Text('diary'.tr, style: AppStyles.treaningTitle),
                  SizedBox(height: Get.height * 0.1),
                  PrimaryButton(
                      text: 'voice_record'.tr,
                      pWidth: 0.5,
                      onPressed: () => Get.to(TimerRecordSuccessScreen())),
                  SizedBox(height: Get.height * 0.04),
                  PrimaryButton(
                      text: 'written_record'.tr,
                      pWidth: 0.5,
                      onPressed: () => Get.to(NoteScreen()))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
