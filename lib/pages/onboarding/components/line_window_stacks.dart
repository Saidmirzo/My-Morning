import 'package:flutter/material.dart';

class WindowLineStack extends StatelessWidget {
  WindowLineStack(
      {Key key,
      this.windowLineImage,
      this.textLineWindowOne,
      this.textLineWindowTwo})
      : super(key: key);
  String windowLineImage;
  String textLineWindowOne;
  String textLineWindowTwo;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 25.0),
          color: Colors.transparent,
          height: 115,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 55,
                  ),
                  RichText(
                    text: TextSpan(
                      text: textLineWindowOne,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xff6B0496),
                        fontWeight: FontWeight.w700,
                      ),
                      children: [
                        TextSpan(
                          text: textLineWindowTwo,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Image.asset(
            windowLineImage,
            width: 80,
          ),
        )
      ],
    );
  }
}
