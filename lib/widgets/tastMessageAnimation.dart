import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class ToastMessageAnimation extends StatelessWidget {
  final Widget child;

  const ToastMessageAnimation(this.child, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("translateY")
          .add(
        const Duration(milliseconds: 250),
        Tween(begin: -100.0, end: 0.0),
        curve: Curves.easeOut,
      )
          .add(const Duration(seconds: 1, milliseconds: 250),
          Tween(begin: 0.0, end: 0.0))
          .add(const Duration(milliseconds: 250), Tween(begin: 0.0, end: -100.0),
          curve: Curves.easeIn),
      Track("opacity")
          .add(const Duration(milliseconds: 500), Tween(begin: 0.0, end: 1.0))
          .add(const Duration(seconds: 1), Tween(begin: 1.0, end: 1.0))
          .add(const Duration(milliseconds: 500), Tween(begin: 1.0, end: 0.0)),
    ]);

    return ControlledAnimation(
      duration: tween.duration,
      tween: tween,
      child: child,
      builderWithChild: (context, child, animation) => Opacity(
        opacity: animation["opacity"],
        child: Transform.translate(
            offset: Offset(0, animation["translateY"]), child: child),
      ),
    );
  }
}