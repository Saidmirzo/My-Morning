import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:morningmagic/pages/progress/progress_page.dart';
import 'package:morningmagic/resources/svg_assets.dart';
import 'package:morningmagic/services/analitics/all.dart';

import '../../screenFAQ.dart';

class BottomMenu extends StatelessWidget {
  final double btnSize = 30;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      color: Colors.transparent,
      child: Container(
        width: Get.width,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.05),
                spreadRadius: 3,
                blurRadius: 5,
              ),
            ],
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            color: Colors.white),
        child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CupertinoButton(
                  padding: const EdgeInsets.only(top: 5),
                  child: SvgPicture.asset(
                    SvgAssets.progress,
                    width: btnSize,
                    height: btnSize,
                  ),
                  onPressed: _openProgress),
              CupertinoButton(
                  padding: const EdgeInsets.only(top: 5),
                  child: SvgPicture.asset(
                    SvgAssets.question,
                    width: btnSize,
                    height: btnSize,
                  ),
                  onPressed: _openFaq),
            ],
          ),
        ),
      ),
    );
  }

  _openFaq() {
    appAnalitics.logEvent('first_faq');
    Get.to(FAQScreen());
  }

  _openProgress() {
    appAnalitics.logEvent('first_menu_progress');
    Get.to(ProgressPage());
  }
}
