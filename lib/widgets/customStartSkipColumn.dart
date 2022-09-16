import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'animatedButton.dart';

class StartSkipColumn extends StatelessWidget {
  final VoidCallback startCallback;
  final GestureTapCallback gestureTapCallback;
  final GestureTapCallback mainMenuCallback;
  final String buttonText;

  // ignore: use_key_in_widget_constructors
  const StartSkipColumn(this.startCallback, this.gestureTapCallback,
      this.mainMenuCallback, this.buttonText);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: AnimatedButton(startCallback, buttonText, 15, null, null),
        ),
        Container(
          padding: const EdgeInsets.only(top: 10),
          child: AnimatedButton(gestureTapCallback, 'skip'.tr, 15, null, null),
        ),
        Container(
          padding: const EdgeInsets.only(top: 10),
          child: AnimatedButton(mainMenuCallback, 'menu'.tr, 15, null, null),
        )
      ],
    );
  }
}
