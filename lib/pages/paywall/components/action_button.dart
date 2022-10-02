
import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {

  final String title;
  final VoidCallback onTap;

  const ActionButton({
    Key key,
    @required this.title,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 66.67,
        width: double.maxFinite,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xff6B0496),
          border: Border.all(
            color: const Color.fromRGBO(255, 255, 255, 0.21),
            width: 4,
          ),
          borderRadius: BorderRadius.circular(19),
        ),
        child: Text(title,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 14,
            color: Colors.white,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
    );
  }
}
