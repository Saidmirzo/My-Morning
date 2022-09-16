import 'package:flutter/material.dart';

class Window extends StatelessWidget {
  const Window({
    Key key,
    this.windowiImage,
    this.windowTextOne,
    this.windowTextTwo,
    this.windowTextThree,
  }) : super(key: key);
  final String windowiImage;
  final String windowTextOne;
  final String windowTextTwo;
  final String windowTextThree;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: (size.width - 70) / 2,
      height: 200,
      // margin: const EdgeInsets.symmetric(horizontal: 6.5),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Image.asset(
              windowiImage,
              // fit: BoxFit.fitWidth,
              height: 100,
              // width: 104,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: windowTextOne,
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xff6B0496),
                fontWeight: FontWeight.w700,
              ),
              children: [
                TextSpan(
                    text: windowTextTwo,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    )),
                TextSpan(
                    text: windowTextThree,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xff6B0496),
                      fontWeight: FontWeight.w700,
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
