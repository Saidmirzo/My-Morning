import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

TextSpan myUrl(String text, String url,
    {Color textColor = Colors.black54, bool underline = true}) {
  return TextSpan(
    text: text,
    style: TextStyle(
        color: textColor,
        decoration: underline ? TextDecoration.underline : null,
        fontSize: 10),
    recognizer: TapGestureRecognizer()
      ..onTap = () async {
        print('Url click');
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          print('Can\'t launch url: $url');
        }
      },
  );
}
