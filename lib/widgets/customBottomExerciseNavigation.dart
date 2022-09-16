import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'animatedButton.dart';

class BottomExerciseNavigation extends StatelessWidget {
  final GestureTapCallback soundCallback;
  final VoidCallback nextCallback;

  const BottomExerciseNavigation(
      {@required this.soundCallback, @required this.nextCallback});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(bottom: 15),
            child:
                AnimatedButton(soundCallback, 'listen_to'.tr, 20, null, null),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 16),
            child: AnimatedButton(
                nextCallback, 'next_exercise'.tr, 19, 270.0, null),
          ),
        ],
      ),
    );
  }
}
