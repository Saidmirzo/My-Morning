import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:morningmagic/app_states.dart';
import 'package:morningmagic/db/model/exercise_time/exercise_time.dart';
import 'package:morningmagic/pages/loading/evening.dart';
import 'package:morningmagic/pages/loading/morning.dart';
import 'package:morningmagic/pages/menu/main_menu.dart';
import 'package:morningmagic/pages/nigth/nigth.dart';
import 'package:morningmagic/pages/settings/settingsPage.dart';
import 'package:morningmagic/pages/welcome/welcome_page.dart';
import 'package:morningmagic/routing/app_routing.dart';
import 'package:morningmagic/services/analitics/analyticService.dart';

import '../../db/hive.dart';
import '../../db/resource.dart';
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
      menuState = MenuState.NIGT;
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
                        onDone: () =>
                            AppRouting.replace(chooseNavigationRoute()))
                    : NightPage(onDone: _redirect),
      ],
    ));
  }

  Widget chooseNavigationRoute() {
    calculateOpanApp();
    if (myDbBox != null && myDbBox.get(MyResource.USER_KEY) != null) {
      return getMenuPage();
    } else {
      AnalyticService.analytics.logAppOpen();
      return WelcomePage();
    }
  }

  Widget getMenuPage() {
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

    if (eventName != null) {
      AnalyticService.analytics.logEvent(
        name: eventName,
        parameters: <String, dynamic>{'bool': true},
      );
    }

    return menuState == MenuState.NIGT ? MainMenuNightPage() : MainMenuPage();
  }

  void calculateOpanApp() {
    MyDB().getBox().put(MyResource.COUNT_APP_LAUNCH,
        MyDB().getBox().get(MyResource.COUNT_APP_LAUNCH, defaultValue: 0) + 1);
    MyDB().getBox().put(MyResource.LAUNCH_FOR_RATE,
        MyDB().getBox().get(MyResource.LAUNCH_FOR_RATE, defaultValue: 0) + 1);

    print(
        'launch app for rate    :    ${MyDB().getBox().get(MyResource.LAUNCH_FOR_RATE, defaultValue: 0)}');
  }

  _redirect() async {
    AppRouting.replace(chooseNavigationRoute());
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
    if (MyDB().getBox().get(MyResource.DIARY_TIME_KEY) == null) {
      MyDB().getBox().put(MyResource.DIARY_TIME_KEY, ExerciseTime(3));
    }
    if (MyDB().getBox().get(MyResource.READING_TIME_KEY) == null) {
      MyDB().getBox().put(MyResource.READING_TIME_KEY, ExerciseTime(3));
    }
    if (MyDB().getBox().get(MyResource.VISUALIZATION_TIME_KEY) == null) {
      MyDB().getBox().put(MyResource.VISUALIZATION_TIME_KEY, ExerciseTime(3));
    }
  }
}
