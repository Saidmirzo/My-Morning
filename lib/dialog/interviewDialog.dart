import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/pages/interview/interview_page.dart';

import '../resources/colors.dart';

class InterviewDialog extends Dialog {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: Get.width * 0.8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'interview_dialog_text'.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: Colors.black),
                ),
                const SizedBox(height: 30),
                CupertinoButton(
                  child: Text(
                    'help_us'.tr,
                    style: TextStyle(
                      color: AppColors.VIOLET,
                    ),
                  ),
                  onPressed: () async {
                    Get.back();
                    Get.to(InterviewPage());
                  },
                ),
                CupertinoButton(
                    child: Text(
                      'more_not_show'.tr,
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () {
                      MyDB().getBox().put(MyResource.IS_DONE_INTERVIEW, true);
                      Get.back();
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
