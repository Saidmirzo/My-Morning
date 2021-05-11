import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/model/user/user.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/resources/colors.dart';

Widget nameWidget(String timeType) {
  User user = myDbBox?.get(MyResource.USER_KEY);
  if (user == null) return Container(width: 0, height: 0);

  return Positioned(
    top: Get.height * 0.3,
    child: Text(
      timeType.tr + user.name,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: AppColors.WHITE,
        fontSize: 26,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}
