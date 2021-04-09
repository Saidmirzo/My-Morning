import 'package:flutter/cupertino.dart';
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
    return CupertinoButton(
      onPressed: onPressed,
      child: SizedBox(
        width: size,
        height: size,
        child: Container(
          child: icon,
          alignment: Alignment.center,
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: bgColor,
          ),
        ),
      ),
    );
  }
}
