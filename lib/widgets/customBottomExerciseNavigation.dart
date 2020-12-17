import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'animatedButton.dart';

class BottomExerciseNavigation extends StatelessWidget {
  final GestureTapCallback soundCallback;
  final VoidCallback nextCallback;

  BottomExerciseNavigation(
      {@required this.soundCallback, @required this.nextCallback});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: 15),
            child: AnimatedButton(
                soundCallback, "rex", 'listen_to'.tr(), 20, null, null),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 16),
            child: AnimatedButton(
                nextCallback, 'rex', 'next_exercise'.tr(), 19, 270.0, null),
          ),
        ],
      ),
    );
  }
}
