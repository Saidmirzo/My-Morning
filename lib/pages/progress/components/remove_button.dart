import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/dialog/deleteProgressDialog.dart';
import 'package:morningmagic/routing/app_routing.dart';
import 'package:morningmagic/services/analitics/all.dart';
import 'package:morningmagic/widgets/primary_button.dart';

Widget removeButton() {
  return PrimaryButton(
    onPressed: () {
      Get.dialog(DeleteProgressDialog(
        () async {
          await MyDB().clearWithoutUserName();
          AppRouting.navigateToHomeWithClearHistory();
        },
      ));
      appAnalitics.logEvent('first_dellprogress');
    },
    text: 'remove_progress'.tr,
    pWidth: .5,
  );
}
