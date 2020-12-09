import 'package:flutter/material.dart';
import 'package:morningmagic/widgets/animatedButton.dart';

class FitnessMenuItemButton extends StatelessWidget {
  const FitnessMenuItemButton(
      {Key key,
      @required this.pageId,
      @required this.onPressed,
      @required this.text})
      : super(key: key);

  final String text;
  final int pageId;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AnimatedButton(onPressed, 'rex', text, 20, 220, null);
  }
}
