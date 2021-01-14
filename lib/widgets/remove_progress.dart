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
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) => DeleteProgressDialog(() {
                  setState(() {
                    MyDB().getBox().clear();
                  });
                }));
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Text(
                'remove_progress'.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.VIOLET,
                    fontStyle: FontStyle.normal,
                    fontFamily: 'sans-serif',
                    fontSize: 19),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
