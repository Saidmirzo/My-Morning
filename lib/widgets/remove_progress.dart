import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/dialog/deleteProgressDialog.dart';
import 'package:morningmagic/pages/loadingPage.dart';
import 'package:morningmagic/resources/colors.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:morningmagic/widgets/animatedButton.dart';

import '../main.dart';

class RemoveProgress extends StatefulWidget {
  @override
  State createState() {
    return RemoveProgressState();
  }
}

class RemoveProgressState extends State<RemoveProgress> {
  @override
  Widget build(BuildContext context) {
    return AnimatedButton(() {
      showDialog(
          context: context,
          builder: (BuildContext context) => DeleteProgressDialog(() {
                setState(() {
                  MyDB().getBox().clear();
                });
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoadingPage()),
                    (route) => false);
              }));
    }, 'sans-serif', 'remove_progress'.tr(), 19, 100, FontWeight.normal);
  }
}
