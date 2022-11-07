import 'package:flutter/material.dart';
import 'package:morningmagic/resources/colors.dart';

import 'package:get/get.dart';

class NextColumn extends StatelessWidget {
  const NextColumn({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(bottom: 30),
          child: ButtonTheme(
            minWidth: 170.0,
            height: 50.0,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(38.0)),
                  backgroundColor: AppColors.pink),
              child: Text(
                'continue'.tr,
                style: const TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.normal,
                  fontSize: 21,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
