import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/dialog/deleteProgressDialog.dart';
import 'package:morningmagic/routing/app_routing.dart';
import 'package:morningmagic/widgets/animatedButton.dart';

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
          builder: (BuildContext context) => DeleteProgressDialog(() async {
                await MyDB().clearWithoutUserName();
                AppRouting.navigateToHomeWithClearHistory(context);
              }));
    }, 'remove_progress'.tr, 19, 100, FontWeight.normal);
  }
}
