import 'package:flutter/material.dart';
import 'package:morningmagic/resources/colors.dart';

const _duration = Duration(milliseconds: 500);

class AnimatedButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String title;
  final double fontSize;
  final double width;
  final FontWeight fontWeight;

  const AnimatedButton(this.onPressed, this.title, this.fontSize, this.width, this.fontWeight);

  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
  Color buttonColor;
  Color textColor;
  bool switcher;

  Color getButtonColor() {
    return switcher ? AppColors.PINK : AppColors.TRANSPARENT;
  }

  Color getTextColor() {
    return switcher ? AppColors.WHITE : AppColors.VIOLET;
  }

  @override
  void initState() {
    super.initState();
    switcher = false;
    buttonColor = AppColors.TRANSPARENT;
    textColor = AppColors.VIOLET;
  }

  void change() {
    setState(() {
      switcher = !switcher;
      buttonColor = getButtonColor();
      textColor = getTextColor();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        duration: _duration,
        decoration: const BoxDecoration(),
        child: ButtonTheme(
          minWidth: widget.width ?? 180.0,
          height: 50.0,
          child: ElevatedButton(
            autofocus: false,
            style: ElevatedButton.styleFrom(
                elevation: 0,
                animationDuration: _duration,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(38.0)),
                backgroundColor: buttonColor),
            onPressed: () {
              change();
              widget.onPressed();
            },
            child: Container(
              padding: const EdgeInsets.only(top: 3),
              child: Text(
                widget.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textColor,
                  fontStyle: FontStyle.normal,
                  fontWeight: widget.fontWeight ?? FontWeight.w400,
                  fontSize: widget.fontSize ?? 23,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
