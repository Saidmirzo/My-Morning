import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/resources/styles.dart';

class PrimaryButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final Widget child;

  /// Процент от ширины экрана 0 - 1
  /// По умолчанию на ширину текста + пэддинг
  final double pWidth;
  const PrimaryButton(
      {Key key, this.onPressed, this.text, this.child, this.pWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Container(
        width: pWidth != null ? Get.width * pWidth : null,
        padding: const EdgeInsets.symmetric(vertical: 20),
        alignment: Alignment.center,
        child: Text(text, style: AppStyles.btnTextStyle),
      ),
      style: ElevatedButton.styleFrom(
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(16.0),
        ),
        primary: Colors.white,
      ),
    );
  }
}
