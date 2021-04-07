import 'package:morningmagic/routing/app_routing.dart';
import 'package:morningmagic/services/analitics/all.dart';
import 'package:morningmagic/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget menuButton() {
  return PrimaryButton(
    onPressed: () {
      AppRouting.navigateToHomeWithClearHistory();
      appAnalitics.logEvent('first_mainemenu');
    },
    text: 'menu'.tr,
    pWidth: .5,
  );
}
