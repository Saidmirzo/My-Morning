import 'dart:async';
import 'package:flutter/material.dart';

class AnimatedWidgetCustom extends StatefulWidget {
  const AnimatedWidgetCustom({Key key}) : super(key: key);
  @override
  State<AnimatedWidgetCustom> createState() => _AnimatedWidgetState();
}

class _AnimatedWidgetState extends State<AnimatedWidgetCustom> {
  bool opacityContainerAnimacion = false;
  bool visiblity = true;
  bool setStateDisabled = true;
  @override
  void initState() {
    durFunc();
    super.initState();
  }

  @override
  void dispose() {
    setStateDisabled = false;
    super.dispose();
  }

  void durFunc() {
    Timer.periodic(const Duration(milliseconds: 1), (e) {
      opacityContainerAnimacion = true;
      e.cancel();
      if (setStateDisabled) {
        setState(() {});
      }
    });
    Timer.periodic(const Duration(milliseconds: 1500), (b) {
      visiblity = false;
      b.cancel();
      if (setStateDisabled) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visiblity,
      child: AnimatedContainer(
        padding: const EdgeInsets.all(1),
        duration: const Duration(
          milliseconds: 1100,
        ),
        color: opacityContainerAnimacion == false
            ? Colors.white60.withOpacity(0.9)
            : Colors.white60.withOpacity(0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
      ),
    );
  }
}
