import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/other.dart';

class BottomButtons extends StatelessWidget {

  const BottomButtons({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String urltermsandroid = 'https://good-apps.org/morning/terms.html';
    String urltermsios = 'https://good-apps.org/my_morning/terms.html';
    String urlprivacyandroid =
        'https://good-apps.org/morning/privacy_policy.html';
    String urlprivacyios =
        'https://good-apps.org/my_morning/privacy_policy.html';
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        MyTextButton(
          onClick: (() {
            Platform.isAndroid
                ? openUrl(urltermsandroid)
                : openUrl(urltermsios);
          }),
          text: 'Terms'.tr,
        ),
        MyTextButton(
          onClick: () {
            Platform.isAndroid
                ? openUrl(urlprivacyandroid)
                : openUrl(urlprivacyios);
          },
          text: 'Privacy'.tr,
        ),
      ],
    );
  }
}

class MyTextButton extends StatelessWidget {
  const MyTextButton({Key key, @required this.onClick, @required this.text})
      : super(key: key);
  final VoidCallback onClick;
  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          fontFamily: 'Montserrat',
        ),
      ),
    );
  }
}
