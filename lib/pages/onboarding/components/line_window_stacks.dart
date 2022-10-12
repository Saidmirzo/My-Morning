import 'package:flutter/material.dart';

class WindowLineStack extends StatelessWidget {

  WindowLineStack({
    Key key,
      this.windowLineImage,
      this.textLineWindowOne,
      this.textLineWindowTwo,
  }) : super(key: key);

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
          height: 125,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 55,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                        children: [
                          TextSpan(
                            text: textLineWindowOne,
                            style: const TextStyle(
                              color: Color(0xff6B0496),
                            ),
                          ),
                          TextSpan(
                            text: textLineWindowTwo,
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
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
