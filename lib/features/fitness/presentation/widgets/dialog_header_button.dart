import 'package:flutter/material.dart';
import 'package:morningmagic/resources/colors.dart';

class DialogHeaderButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const DialogHeaderButton({Key key, @required this.text, @required this.onTap})
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
          style: const TextStyle(
              fontSize: 23,
              fontStyle: FontStyle.normal,
              color: AppColors.VIOLET),
        ),
      ),
    );
  }
}
