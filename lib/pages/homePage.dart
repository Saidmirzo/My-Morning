import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/app_gradient_container.dart';
import 'package:morningmagic/pages/screenFAQ.dart';
import 'package:morningmagic/routing/route_values.dart';
import 'package:morningmagic/services/analitics/all.dart';
import 'package:morningmagic/services/analitics/analyticService.dart';
import 'package:morningmagic/utils/reordering_util.dart';
import 'package:morningmagic/widgets/primary_button.dart';

import '../db/hive.dart';
import '../db/model/exercise/exercise_holder.dart';
import '../db/model/progress/day/day_holder.dart';
import '../db/resource.dart';
import '../pages/screenProgress.dart';
import '../widgets/animatedButton.dart';
import 'progress/progress_page.dart';

class HomePage extends StatefulWidget {
  @override
  State createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  int dayHolderSize;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      dayHolderSize = await _getDaysLength();
    });

    _clearExercisesHolder();
    AnalyticService.screenView('menu_page');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AppGradientContainer(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: Get.width * 0.18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                // Начать
                PrimaryButton(
                    onPressed: () => _startExercise(), text: 'start'.tr),
                SizedBox(height: 15),
                // Прогресс
                PrimaryButton(
                    onPressed: () => _openProgress(_selectProgressPage()),
                    text: 'progress_item'.tr),
                SizedBox(height: 15),
                // Настройки
                PrimaryButton(
                    onPressed: () => _openSettings(), text: 'settings'.tr),
                SizedBox(height: 15),
                // Помощь
                PrimaryButton(onPressed: () => _openFaq(), text: 'faq'.tr),
                SizedBox(height: MediaQuery.of(context).size.height / 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<int> _getDaysLength() async {
    DayHolder dayHolder = await MyDB().getBox().get(MyResource.DAYS_HOLDER);
    if (dayHolder == null) return 0;
    return dayHolder.listOfDays.length;
  }

  _clearExercisesHolder() async {
    await MyDB()
        .getBox()
        .put(MyResource.EXERCISES_HOLDER, ExerciseHolder([], []));
  }

  Widget _selectProgressPage() {
    if (dayHolderSize != null && dayHolderSize > 0) {
      return ProgressPage();
    } else {
      return ProgressScreen();
    }
  }

  _startExercise() async {
    appAnalitics.logEvent('first_start');
    await OrderUtil().getRouteByPositionInList(0).then((value) {
      Get.off(value);
    });
  }

  _openProgress(Widget widget) {
    appAnalitics.logEvent('first_menu_progress');
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
  }

  _openSettings() {
    appAnalitics.logEvent('first_menu_setings');
    Navigator.pushNamed(context, settingsPageRoute);
  }

  _openFaq() {
    appAnalitics.logEvent('first_faq');
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => FAQScreen()));
  }
}
