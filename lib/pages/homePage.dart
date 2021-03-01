import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:morningmagic/analyticService.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/app_gradient_container.dart';
import 'package:morningmagic/pages/screenFAQ.dart';
import 'package:morningmagic/routing/route_values.dart';
import 'package:morningmagic/utils/reordering_util.dart';

import '../db/hive.dart';
import '../db/model/exercise/exercise_holder.dart';
import '../db/model/progress/day/day_holder.dart';
import '../db/resource.dart';
import '../pages/screenProgress.dart';
import '../widgets/animatedButton.dart';
import 'askedQuestionsScreen.dart';

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              // Начать
              AnimatedButton(() => _startExercise(), 'sans-serif', 'start'.tr(),
                  null, null, null),
              SizedBox(height: 15),
              // Прогресс
              AnimatedButton(() => _openProgress(_selectProgressPage()),
                  "sans-serif", 'progress_item'.tr(), null, null, null),
              SizedBox(height: 15),
              // Настройки
              AnimatedButton(() => _openSettings(), "sans-serif",
                  'settings'.tr(), null, null, null),
              SizedBox(height: 15),
              // Помощь
              AnimatedButton(
                  () => _openFaq(), "sans-serif", 'faq'.tr(), null, null, null),
              SizedBox(height: MediaQuery.of(context).size.height / 10),
            ],
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
      return AskedQuestionsScreen();
    } else {
      return ProgressScreen();
    }
  }

  _startExercise() {
    OrderUtil().getRouteByPositionInList(0).then((value) {
      Navigator.push(context, value);
    });
  }

  _openProgress(Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
  }

  _openSettings() {
    Navigator.pushNamed(context, settingsPageRoute);
  }

  _openFaq() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => FAQScreen()));
  }
}
