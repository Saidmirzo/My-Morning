import 'package:flutter/material.dart';

class BrandButtons extends StatelessWidget {
  const BrandButtons({
    Key key,
    @required this.text,
    @required this.onTap,
    this.style,
    this.color,
    this.borderColor,
    this.isLoad = false,
  }) : super(key: key);
  final String text;
  final VoidCallback onTap;
  final TextStyle style;
  final Color color;
  final Color borderColor;
  final bool isLoad;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(minHeight: 200),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(63),
          color: color ?? const Color(0xff664EFF),
          border: Border.all(
            width: 12,
            color: borderColor ?? const Color(0xFFFFFFFF).withOpacity(0.9).withOpacity(0.21),
          ),
        ),
        child: isLoad
            ? const SizedBox(
                height: 60,
                width: 60,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : Text(
                text,
                style: style ??
                    TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFFFFFFFF).withOpacity(0.9),
                    ),
              ),
      ),
    );
  }
}
