import 'package:flutter/material.dart';
import 'package:morningmagic/resources/colors.dart';

class DialogActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const DialogActionButton({Key key, @required this.text, @required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 23,
              fontFamily: 'rex',
              fontStyle: FontStyle.normal,
              color: AppColors.VIOLET),
        ),
      ),
    );
  }
}
