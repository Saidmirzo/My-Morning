import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/dialog/deleteProgressDialog.dart';
import 'package:morningmagic/resources/colors.dart';

import 'package:easy_localization/easy_localization.dart';

class RemoveProgress extends StatefulWidget {
  @override
  State createState() {
    return RemoveProgressState();
  }
}

class RemoveProgressState extends State<RemoveProgress> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 10, top: 15),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'remove_progress'.tr(),
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: AppColors.VIOLET,
                  fontStyle: FontStyle.normal,
                  fontFamily: 'sans-serif-black',
                  fontSize: 26),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 15),
          child: GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => DeleteProgressDialog(() {
                        setState(() {
                          MyDB().getBox().clear();
                        });
                      }));
            },
            child: Container(
              width: 45,
              height: 45,
              child: SvgPicture.asset("assets/svg/trash.svg",
                  color: AppColors.WHITE),
            ),
          ),
        )
      ],
    );
  }
}
