import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TitleSubtitlePaywall extends StatelessWidget {
  TitleSubtitlePaywall({Key key}) : super(key: key);

  final titleStyle = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: Get.locale == const Locale('de') ? 21 : 28,
    color: Colors.white,
    fontFamily: 'Montserrat',
  );
  final subtitleStyle = const TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 15,
    color: Colors.white,
    fontFamily: 'Montserrat',
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Unlock all features'.tr,
          style: titleStyle,
        ),
        const SizedBox(
          height: 8,
        ),
        Text("Build your perfect morning routine".tr,
          style: subtitleStyle,
        ),
      ],
    );
  }
}
