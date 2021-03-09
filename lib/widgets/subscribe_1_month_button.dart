
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../storage.dart';
import 'animatedButton.dart';
import 'is_pro_widget.dart';

class Subscribe1MonthButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if(billingService.isPro()) return IsProWidget();
    return Column(
      children: [
        Center(
          child: AnimatedButton(() async {
            billingService.startPaymentPage(context);
          }, 'sans-serif', 'pay'.tr, null, null, null
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}