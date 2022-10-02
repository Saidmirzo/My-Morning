
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../resources/svg_assets.dart';

class SafetyShield extends StatelessWidget {

  const SafetyShield({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 14,
      fontFamily: 'Montserrat',
    );
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.95,
        vertical: 9.33,
      ),
      // height: double.maxFinite,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(21),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          children: [
            // Щит
            Image.asset(MyImages.paywallSecure),
            const SizedBox(width: 7.3),
            // Текст
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Secured with Apple Store'.tr,
                  style: textStyle.copyWith(
                    color: const Color(0xFF000000),
                  ),
                ),
                Text('Cancel anytime'.tr,
                  style: textStyle.copyWith(
                    color: const Color(0xFF664EFF),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
