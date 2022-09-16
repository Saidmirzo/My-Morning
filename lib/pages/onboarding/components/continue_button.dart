import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContinueButton extends StatelessWidget {
  const ContinueButton({Key key, this.callback}) : super(key: key);
  final VoidCallback callback;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        width: double.maxFinite,
        margin: const EdgeInsets.only(left: 14.3, right: 14.3, bottom: 39),
        padding: const EdgeInsets.symmetric(
          vertical: 22.23,
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xff6B0496),
          borderRadius: BorderRadius.circular(19),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.53),
              blurRadius: 50,
              spreadRadius: 10,
              offset: const Offset(5, 20),
            ),
          ],
        ),
        child: Text(
          'Continue'.tr,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
    );
  }
}
