import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:morningmagic/analyticService.dart';
import 'package:morningmagic/app_states.dart';
import 'package:morningmagic/db/model/exercise_time/exercise_time.dart';
import 'package:morningmagic/routing/route_values.dart';

import '../db/hive.dart';
import '../db/model/user/user.dart';
import '../db/resource.dart';
import '../resources/colors.dart';
import '../storage.dart';

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
    super.initState();
    print('LoadingPage initState');
    initController();
    _initTimerValue();
    billingService.init();
    initRedirect();
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

  Future<void> _sendAnalyticsEventThirty() async {
    await AnalyticService.analytics.logEvent(
      name: 'thirtyLaunches',
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
      'good_morning'.tr + user.name + "!",
      textAlign: TextAlign.center,
      style: TextStyle(
        color: AppColors.WHITE,
        fontSize: 26,
      ),
    );
  }

  String chooseNavigationRoute() {
    if (myDbBox != null && myDbBox.get(MyResource.USER_KEY) != null) {
      return chooseSettingsOrStartMenu();
    } else {
      AnalyticService.analytics.logAppOpen();
      return userInputDataPageRoute;
    }
  }

  String chooseSettingsOrStartMenu() {
    int launchForRate = MyDB().getBox().get(MyResource.LAUNCH_FOR_RATE) ?? 0;
    launchForRate++;
    MyDB().getBox().put(MyResource.LAUNCH_FOR_RATE, launchForRate);

    MyDB().getBox().put(
        MyResource.COUNT_APP_LAUNCH,
        MyDB().getBox().get(MyResource.COUNT_APP_LAUNCH) != null
            ? (MyDB().getBox().get(MyResource.COUNT_APP_LAUNCH) + 1)
            : 1);
    switch (MyDB().getBox().get(MyResource.COUNT_APP_LAUNCH)) {
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
      case 30:
        {
          _sendAnalyticsEventThirty();
          break;
        }
    }

    if (myDbBox != null &&
        myDbBox.get(MyResource.BOOK_KEY) != null &&
        myDbBox.get(MyResource.AFFIRMATION_TEXT_KEY) != null) {
      return homePageRoute;
    } else {
      return settingsPageRoute;
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

  initRedirect() async {
    await Future.delayed(Duration(seconds: 3));
    _openScreen();
  }

  void _openScreen() async {
    await Navigator.pushReplacementNamed(
      context,
      chooseNavigationRoute(),
    );
  }

  void _initTimerValue() {
    if (MyDB().getBox().get(MyResource.AFFIRMATION_TIME_KEY) == null) {
      MyDB().getBox().put(MyResource.AFFIRMATION_TIME_KEY, ExerciseTime(3));
    }
    if (MyDB().getBox().get(MyResource.MEDITATION_TIME_KEY) == null) {
      MyDB().getBox().put(MyResource.MEDITATION_TIME_KEY, ExerciseTime(3));
    }
    if (MyDB().getBox().get(MyResource.FITNESS_TIME_KEY) == null) {
      MyDB().getBox().put(MyResource.FITNESS_TIME_KEY, ExerciseTime(3));
    }
    if (MyDB().getBox().get(MyResource.VOCABULARY_TIME_KEY) == null) {
      MyDB().getBox().put(MyResource.VOCABULARY_TIME_KEY, ExerciseTime(3));
    }
    if (MyDB().getBox().get(MyResource.READING_TIME_KEY) == null) {
      MyDB().getBox().put(MyResource.READING_TIME_KEY, ExerciseTime(3));
    }
    if (MyDB().getBox().get(MyResource.VISUALIZATION_TIME_KEY) == null) {
      MyDB().getBox().put(MyResource.VISUALIZATION_TIME_KEY, ExerciseTime(3));
    }
  }
}
