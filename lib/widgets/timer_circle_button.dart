import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimerCircleButton extends StatelessWidget {
  final Widget child;
  final Function onPressed;

  const TimerCircleButton(
      {Key key, @required this.child, @required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    BorderRadius borderRadius = BorderRadius.circular(50);
    return CupertinoButton(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: Colors.white24,
          ),
          padding: const EdgeInsets.all(5),
          child: Container(
            child: child,
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              color: Colors.white,
            ),
          ),
        ),
        onPressed: onPressed);
  }
}
