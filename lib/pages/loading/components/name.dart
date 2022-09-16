import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/model/user/user.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/resources/colors.dart';

Widget nameWidget(String timeType, {double top}) {
  User user = myDbBox?.get(MyResource.USER_KEY);
  if (user == null) return const SizedBox(width: 0, height: 0);

  return Positioned(
    top: top ?? Get.height * 0.3,
    child: Text(
      user.name.isEmpty?timeType.tr
     :timeType.tr +',\n'+ user.name,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: AppColors.WHITE,
        fontSize: 26,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}
