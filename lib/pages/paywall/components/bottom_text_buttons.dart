import 'dart:io';
import 'package:flutter/material.dart';
import '../../../utils/other.dart';

class TextButtonsPayWall extends StatelessWidget {
  const TextButtonsPayWall({
    Key key,
    @required this.restore,
  }) : super(key: key);
  final VoidCallback restore;
  @override
  Widget build(BuildContext context) {
    String urltermsandroid = 'https://good-apps.org/morning/terms.html';
    String urltermsios = 'https://good-apps.org/my_morning/terms.html';
    String urlprivacyandroid =
        'https://good-apps.org/morning/privacy_policy.html';
    String urlprivacyios =
        'https://good-apps.org/my_morning/privacy_policy.html';
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyTextButton(
          onClick: (() {
            // restore,
          }),
          text: 'Restore',
        ),
        const SizedBox(
          width: 23,
        ),
        MyTextButton(
          // onClick: () async {
          //   if (await canLaunch('agreement_title'.tr)) {
          //     await launch('agreement_title'.tr);
          //   }
          // },
          onClick: (() {
            Platform.isAndroid
                ? openUrl(urltermsandroid)
                : openUrl(urltermsios);
          }),
          text: 'Terms',
        ),
        const SizedBox(
          width: 23,
        ),
        MyTextButton(
          onClick: () {
            Platform.isAndroid
                ? openUrl(urlprivacyandroid)
                : openUrl(urlprivacyios);
          },
          text: 'Privacy',
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
          fontSize: 10,
          fontWeight: FontWeight.w500,
          fontFamily: 'Montserrat',
        ),
      ),
    );
  }
}
