import 'package:flutter/material.dart';
import 'package:morningmagic/resources/colors.dart';

import 'package:get/get.dart';

class NextColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(bottom: 30),
          child: ButtonTheme(
            minWidth: 170.0,
            height: 50.0,
            child: RaisedButton(
              elevation: 0,
              onPressed: () {},
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(38.0)),
              child: Text(
                'continue'.tr,
                style: const TextStyle(
                  color: AppColors.WHITE,
                  fontWeight: FontWeight.normal,
                  fontSize: 21,
                ),
              ),
              color: AppColors.PINK,
            ),
          ),
        ),
      ],
    );
  }
}
