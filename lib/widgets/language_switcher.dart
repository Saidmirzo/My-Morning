import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/services/localization/localization_service.dart';

import '../resources/colors.dart';

class LanguageSwitcher extends StatefulWidget {
  final Alignment alignment;

  LanguageSwitcher({this.alignment = Alignment.center});

  @override
  LanguageSwitcherState createState() {
    return LanguageSwitcherState();
  }
}

class LanguageSwitcherState extends State<LanguageSwitcher> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
          child: Align(
            alignment: widget.alignment,
            child: Text(
              'language'.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.normal,
                fontSize: Get.height * 0.022,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildBtn('Русский', LocalizationService.RU),
            const SizedBox(width: 20),
            buildBtn('English', LocalizationService.EN),
          ],
        )
      ],
    );
  }

  Widget buildBtn(String text, String lang) {
    bool isActive = Get.locale.languageCode == lang;
    return Container(
      width: 120,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: isActive ? Colors.white : Color(0xffEAC5D2)),
      child: CupertinoButton(
        child: Text(
          text,
          style: TextStyle(color: !isActive ? Colors.white : AppColors.primary),
        ),
        onPressed: () {
          LocalizationService.switchLocale(lang);
        },
      ),
    );
  }
}
