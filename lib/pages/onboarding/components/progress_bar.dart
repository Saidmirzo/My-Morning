import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({Key key, this.page}) : super(key: key);
  final int page;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Container(
          margin: const EdgeInsets.only(
            left: 28,
            right: 28,
          ),
          width: double.maxFinite,
          height: 5.3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(62),
            color: const Color(0xff592F72),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
            left: 28,
            right: 28,
          ),
          width: getProcent(),
          height: 5.3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(62),
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  double getProcent(){
    double full = Get.width - 56;
    double onePageProcent = full / 10;
    return onePageProcent * page;
  }
}