import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'animatedButton.dart';

class StartSkipColumn extends StatelessWidget {
  final VoidCallback startCallback;
  final GestureTapCallback gestureTapCallback;
  final GestureTapCallback mainMenuCallback;
  final String buttonText;

  StartSkipColumn(this.startCallback, this.gestureTapCallback,
      this.mainMenuCallback, this.buttonText);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child:
              AnimatedButton(startCallback, 'rex', buttonText, 15, null, null),
        ),
        Container(
          padding: EdgeInsets.only(top: 10),
          child:
              AnimatedButton(gestureTapCallback, 'rex', 'skip'.tr(), 15, null, null),
        ),
        Container(
          padding: EdgeInsets.only(top: 10),
          child:
              AnimatedButton(mainMenuCallback, 'rex', 'menu'.tr(), 15, null, null),
        )
      ],
    );
  }
}
