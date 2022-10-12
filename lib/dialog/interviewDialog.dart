import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/pages/interview/interview1/interview_page.dart';
import '../resources/colors.dart';
import '../storage.dart';

class InterviewDialog extends Dialog {
  const InterviewDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Stack(
          children: [
            Container(
              width: Get.width * 0.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 50),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      billingService.isPro()
                          ? 'interview_dialog_text_vip'.tr
                          : 'interview_dialog_text'.tr,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          color: Colors.black),
                    ),
                    const SizedBox(height: 30),
                    CupertinoButton(
                      child: Text(
                        'help_us'.tr,
                        style: const TextStyle(
                          color: AppColors.VIOLET,
                        ),
                      ),
                      onPressed: () async {
                        Get.back();
                        Get.to(() => InterviewPage());
                      },
                    ),
                    CupertinoButton(
                        child: Text(
                          'more_not_show'.tr,
                          style: const TextStyle(color: Colors.red),
                        ),
                        onPressed: () {
                          MyDB()
                              .getBox()
                              .put(MyResource.IS_DONE_INTERVIEW, true);
                          Get.back();
                        }),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 0,
              child: CupertinoButton(
                  child: const Icon(Icons.close, color: Colors.black),
                  onPressed: Get.back),
            )
          ],
        ),
      ),
    );
  }
}
