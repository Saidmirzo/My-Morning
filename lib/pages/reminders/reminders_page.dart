import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/widgets/primary_circle_button.dart';

class RemindersPage extends StatefulWidget {
  @override
  _RemindersPageState createState() => _RemindersPageState();
}

class _RemindersPageState extends State<RemindersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        decoration: BoxDecoration(gradient: AppColors.gradient_settings_page),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: Get.height * 0.92,
              width: Get.width,
              child: Column(
                children: [
                  Row(
                    children: [
                      PrimaryCircleButton(
                        onPressed: () => Get.back(),
                        icon: Icon(Icons.arrow_back_ios_new,
                            color: Colors.black54),
                        bgColor: Colors.black12,
                      ),
                      Text(
                        'reminders_page'.tr,
                        style: TextStyle(fontSize: Get.height * 0.036),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 7,
                      itemBuilder: (_, i) {
                        return reminder();
                      },
                    ),
                  ),
                  PrimaryCircleButton(
                    onPressed: () {},
                    icon: Icon(Icons.add, color: Colors.black54),
                    bgColor: Colors.black12,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget reminder() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.black12),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Column(
            children: [
              Text(
                '19:00',
                style: TextStyle(
                    fontSize: Get.height * 0.03, fontWeight: FontWeight.w700),
              ),
              Text(
                '22.01.2021',
                style: TextStyle(
                    fontSize: Get.height * 0.017, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(width: 15),
          Expanded(
              child: Text(
            'Текст напоминания Текст напоминания Текст',
            style: TextStyle(
                fontSize: Get.height * 0.017, fontWeight: FontWeight.w500),
          )),
          CupertinoButton(
              child: Icon(Icons.delete, color: Colors.black54),
              onPressed: () {}),
        ],
      ),
    );
  }
}
