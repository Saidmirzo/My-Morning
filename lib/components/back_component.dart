import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BackComponent extends StatelessWidget {
  const BackComponent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: GestureDetector(
        child: const Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 4, 0),
          child: Icon(Icons.west, color: Colors.white, size: 30),
        ),
        onTap: () => Get.back(),
      ),
    );
  }
}
