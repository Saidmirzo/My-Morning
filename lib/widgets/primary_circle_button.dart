import 'package:flutter/material.dart';

class PrimaryCircleButton extends StatelessWidget {
  final Function onPressed;
  final Widget icon;
  final double size;
  final EdgeInsets padding;
  final Color bgColor;

  const PrimaryCircleButton(
      {Key key,
      this.onPressed,
      this.icon,
      this.size = 40,
      this.padding = const EdgeInsets.all(3),
      this.bgColor = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Container(
        child: icon,
        width: size,
        height: size,
        alignment: Alignment.center,
        padding: padding,
      ),
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        primary: bgColor,
      ),
    );
  }
}
