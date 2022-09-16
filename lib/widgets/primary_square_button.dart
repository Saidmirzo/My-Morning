import 'package:flutter/material.dart';

class PrimarySquareButton extends StatelessWidget {
  final Function onPressed;
  final Widget icon;
  final double size;
  final EdgeInsets padding;

  const PrimarySquareButton({
    Key key,
    this.onPressed,
    this.icon,
    this.size = 40,
    this.padding = const EdgeInsets.all(3),
  }) : super(key: key);

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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        primary: Colors.white,
      ),
    );
  }
}
