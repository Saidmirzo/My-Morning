import 'package:flutter/material.dart';

class LineWindow extends StatelessWidget {
  LineWindow(
      {Key key,
      this.imageLineWindow,
      this.lineWindowTextOne,
      this.linewindowTextTwo})
      : super(key: key);
  String imageLineWindow;
  String lineWindowTextOne;
  String linewindowTextTwo;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          Image.asset(
            imageLineWindow,
            width: 54,
          ),
          const SizedBox(
            width: 15,
          ),
          RichText(
            text: TextSpan(
              text: lineWindowTextOne,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xff6B0496),
                fontWeight: FontWeight.w700,
              ),
              children: [
                TextSpan(
                    text: linewindowTextTwo,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
