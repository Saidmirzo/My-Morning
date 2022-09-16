import 'package:flutter/material.dart';
import 'package:morningmagic/resources/colors.dart';
import 'styled_text.dart';

class DialogFooterButton extends StatelessWidget {
  final String text;

  final VoidCallback onPressed;

  const DialogFooterButton(
      {Key key, @required this.text, @required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton.icon(
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
            side: const BorderSide(
                style: BorderStyle.solid, width: 2, color: AppColors.VIOLET),
            borderRadius: BorderRadius.circular(30.0)),
        icon: const Icon(
          Icons.add,
          color: AppColors.VIOLET,
        ),
        label: Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 4),
          child: StyledText(
            text,
            fontSize: 16,
          ),
        ));
  }
}
