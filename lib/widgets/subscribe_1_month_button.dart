import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/services/analitics/all.dart';
import 'package:morningmagic/widgets/primary_button.dart';

import '../storage.dart';

class Subscribe1MonthButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (billingService.isPro()) {
      return Text('tarif_plans_done'.tr, textAlign: TextAlign.center);
    }
    return Column(
      children: [
        Center(
          child: PrimaryButton(
            onPressed: () async {
              appAnalitics.logEvent('first_pay');
              billingService.startPaymentPage();
            },
            text: 'pay'.tr,
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
