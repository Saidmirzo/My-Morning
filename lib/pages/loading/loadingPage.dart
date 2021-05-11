import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:intl/intl.dart';
import 'package:morningmagic/pages/loading/evening.dart';
import 'package:morningmagic/pages/loading/morning.dart';
import 'package:morningmagic/services/analitics/analyticService.dart';
import 'package:morningmagic/app_states.dart';
import 'package:morningmagic/db/model/exercise_time/exercise_time.dart';
import 'package:morningmagic/routing/route_values.dart';

import '../../db/hive.dart';
import '../../db/model/user/user.dart';
import '../../db/resource.dart';
import '../../resources/colors.dart';
import '../../resources/colors.dart';
import '../../storage.dart';
import 'afternoon.dart';
import 'night.dart';

class LoadingPage extends StatefulWidget {
  @override
  LoadingPageState createState() {
    return LoadingPageState();
  }
}

enum TimeType { morning, afternoon, evening, night }

class LoadingPageState extends State<LoadingPage>
    with SingleTickerProviderStateMixin {
  bool switcherSun = false;
  bool firstBuild = false;
  AppStates appStates = Get.put(AppStates());
  TimeType timeType = TimeType.morning;

  @override
  void initState() {
    super.initState();
    print('LoadingPage initState');
    checkTime();
    _initTimerValue();
    billingService.init();
  }

  void checkTime() {
    var h = DateTime.now().hour;
    if (h >= 4 && h < 10) {
      timeType = TimeType.morning;
    } else if (h >= 10 && h < 18) {
      timeType = TimeType.afternoon;
    } else if (h >= 18 && h < 21) {
      timeType = TimeType.evening;
    } else if (h < 4 || h >= 21) {
      timeType = TimeType.night;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      alignment: Alignment.center,
      children: <Widget>[
        timeType == TimeType.morning
            ? MorningPage(onDone: _redirect)
            : timeType == TimeType.afternoon
                ? AfternoonPage(onDone: _redirect)
                : timeType == TimeType.evening
                    ? EveningPage(
                        onDone: () => Navigator.pushReplacementNamed(
                            context, chooseNavigationRoute()))
                    : NightPage(onDone: _redirect),
      ],
    ));
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

    String eventName;
    switch (MyDB().getBox().get(MyResource.COUNT_APP_LAUNCH)) {
      case 2:
        eventName = 'twoLaunches';
        break;
      case 5:
        eventName = 'fiveLaunches';
        break;
      case 10:
        eventName = 'tenLaunches';
        break;
      case 30:
        eventName = 'thirtyLaunches';
        break;
    }

    if (eventName != null)
      AnalyticService.analytics.logEvent(
        name: eventName,
        parameters: <String, dynamic>{'bool': true},
      );

    if (myDbBox != null &&
        myDbBox.get(MyResource.BOOK_KEY) != null &&
        myDbBox.get(MyResource.AFFIRMATION_TEXT_KEY) != null) {
      return homePageRoute;
    } else {
      return settingsPageRoute;
    }
  }

  _redirect() async {
    await Future.delayed(1.seconds);
    Navigator.pushReplacementNamed(context, chooseNavigationRoute());
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
