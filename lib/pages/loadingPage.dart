import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:morningmagic/analyticService.dart';
import 'package:morningmagic/app_states.dart';

import '../db/hive.dart';
import '../db/model/user/user.dart';
import '../db/resource.dart';
import '../resources/colors.dart';
import '../storage.dart';
import 'menuPage.dart';
import 'screenUserDataInput.dart';
import 'settingsPage.dart';

class LoadingPage extends StatefulWidget {
  @override
  LoadingPageState createState() {
    return LoadingPageState();
  }
}

class LoadingPageState extends State<LoadingPage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  bool switcherRay = false;
  bool switcherSun = false;
  bool firstBuild = false;
  AppStates appStates = Get.put(AppStates());

  @override
  void initState() {
    print('LoadingPage initState');
    initController();
    initAndLoadDb();
    billingService.init();
    initRedirect();
    super.initState();
  }

  Future<void> _sendAnalyticsEventTwo() async {
    await AnalyticService.analytics.logEvent(
      name: 'twoLaunches',
      parameters: <String, dynamic>{
        'bool': true,
      },
    );
  }

  Future<void> _sendAnalyticsEventFive() async {
    await AnalyticService.analytics.logEvent(
      name: 'fiveLaunches',
      parameters: <String, dynamic>{
        'bool': true,
      },
    );
  }

  Future<void> _sendAnalyticsEventTen() async {
    await AnalyticService.analytics.logEvent(
      name: 'tenLaunches',
      parameters: <String, dynamic>{
        'bool': true,
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!firstBuild) {
      Future.delayed(const Duration(milliseconds: 500), () {
        controller.forward();
        switcherSun = true;
      });
      firstBuild = true;
    } else {}

    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/sky.png'),
                  fit: BoxFit.cover),
            ),
            child: Visibility(
              visible: switcherSun,
              child: Align(
                alignment: Alignment(0, -0.3),
                child: nameWidget(),
              ),
            )),
        Visibility(
          visible: switcherSun,
          child: Container(
            child: Align(
              alignment: Alignment(-0.05, animation.value),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.width * 0.6,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/clear_sun.png'),
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/mountains.png'),
                fit: BoxFit.cover),
          ),
        ),
        Visibility(
          visible: switcherRay,
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/images/rays.png'),
              fit: BoxFit.cover,
            )),
          ),
        ),
      ],
    ));
  }

  Widget nameWidget() {
    User user = myDbBox?.get(MyResource.USER_KEY);
    if (user == null) return Container(width: 0, height: 0);
    return Text(
      'good_morning'.tr() + user.name + "!",
      textAlign: TextAlign.center,
      style: TextStyle(
        color: AppColors.WHITE,
        fontFamily: 'rex',
        fontSize: 26,
      ),
    );
  }

  Widget chooseNavigationWidget() {
    if (myDbBox != null && myDbBox.get(MyResource.USER_KEY) != null) {
      return chooseSettingsOrStartMenu();
    } else {
      AnalyticService.analytics.logAppOpen();
      return UserDataInputScreen();
    }
  }

  Widget chooseSettingsOrStartMenu() {
    MyDB().getBox().put(
        'countLaunch',
        MyDB().getBox().get('countLaunch') != null
            ? (MyDB().getBox().get('countLaunch') + 1)
            : 1);
    switch (MyDB().getBox().get('countLaunch')) {
      case 2:
        {
          _sendAnalyticsEventTwo();
          break;
        }
      case 5:
        {
          _sendAnalyticsEventFive();
          break;
        }
      case 10:
        {
          _sendAnalyticsEventTen();
          break;
        }
    }
    print(MyDB().getBox().get('countLaunch'));
    if (myDbBox != null &&
        myDbBox.get(MyResource.BOOK_KEY) != null &&
        myDbBox.get(MyResource.AFFIRMATION_TEXT_KEY) != null) {
      return StartScreen();
    } else {
      return SettingsPage();
    }
  }

  void initController() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        switcherRay = true;
      }
    });
    animation = Tween<double>(begin: 1, end: 0.3).animate(controller)
      ..addListener(() {
        setState(() {});
      });
  }

  initAndLoadDb() async {
    try {
      await MyDB().initHiveDatabase();
    } catch (e) {
      print('Hive error: $e');
    }
  }

  initRedirect() async {
    await Future.delayed(Duration(seconds: 3));
    _openScreen();
  }

  void _openScreen() async {
    await Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => chooseNavigationWidget()),
    );
  }
}
