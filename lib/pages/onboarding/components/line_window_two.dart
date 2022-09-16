import 'package:flutter/material.dart';

class LineWindowTwo extends StatelessWidget {
  LineWindowTwo(
      {Key key,
      this.imageLineWindow,
      this.lineWindowTextOne,
      this.linewindowTextTwo,
      this.linewindowTextTree})
      : super(key: key);
  String imageLineWindow;
  String lineWindowTextOne;
  String linewindowTextTwo;
  String linewindowTextTree;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 89,
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
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
              children: [
                TextSpan(
                    text: linewindowTextTwo,
                    style: const TextStyle(
                      color: Color(0xff6B0496),
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    )),
                     TextSpan(
                    text: linewindowTextTree,
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
