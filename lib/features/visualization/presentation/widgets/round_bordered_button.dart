import 'package:flutter/material.dart';

class RoundBorderedButton extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;
  final Color borderColor;

  const RoundBorderedButton(
      {Key key,
      @required this.onTap,
      @required this.child,
      this.borderColor = Colors.black})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: CircleBorder(),
      color: Colors.transparent,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              border: Border.all(width: 3, color: borderColor),
              borderRadius: BorderRadius.circular(28.0),
              color: Colors.transparent,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
