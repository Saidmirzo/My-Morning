import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/dialog/langDialog.dart';
import 'package:morningmagic/resources/colors.dart';

Widget langBtn(BuildContext context) => CupertinoButton(
      onPressed: () => showLangDialog(context),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          width: Get.width * .35,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(18)),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Text(
                'language'.tr,
                style: TextStyle(
                  fontSize: Get.width * .040,
                  fontWeight: FontWeight.normal,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
