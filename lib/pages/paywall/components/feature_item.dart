import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FeatureItem extends StatelessWidget {

  final String img;
  final String text;

  const FeatureItem({
    Key key,
    this.img,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final w = (Get.width - 66) / 3;
    return Container(
      alignment: Alignment.bottomCenter,
      height: 94,
      width: 100,
      // margin: const EdgeInsets.symmetric(horizontal: 7),
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7),
            child: Center(
              child: SizedBox(
              height: 71,
              width: 100,
              child: FittedBox(
                  fit: BoxFit.contain,
                  child: Image.asset(img,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            height: 17,
            // width: w,
            child: Text(text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontFamily: 'Montserrat',
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}