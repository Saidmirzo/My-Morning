import 'package:flutter/material.dart';
import 'package:morningmagic/pages/screenFAQ.dart';
import 'package:morningmagic/pages/settingsPage.dart';
import 'package:morningmagic/utils/reordering_util.dart';

import '../db/hive.dart';
import '../db/model/exercise/exercise_holder.dart';
import '../db/model/exercise/exercise_title.dart';
import '../db/model/progress/day/day_holder.dart';
import '../db/resource.dart';

class MenuService{
  BuildContext context;

  init(BuildContext _context){
    this.context = _context;
  }

  Future<int> getDayHolderSize() async {
    clearExercisesHolder();
    DayHolder dayHolder = await MyDB().getBox().get(MyResource.DAYS_HOLDER);
    if (dayHolder == null) return 0;
    return dayHolder.listOfDays.length;
  }

  clearExercisesHolder() async{
    print("clear EXERCISE HOLDER");
    await MyDB().getBox().put(MyResource.EXERCISES_HOLDER, ExerciseHolder(List<ExerciseTitle>(), List<ExerciseTitle>()));
  }

  btnStart(){
    OrderUtil().getRouteByPositionInList(0).then((value) {
      Navigator.push(context, value);
    });
  }

  btnProgress(Widget widget){
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
  }

  btnSettings(){
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
      builder: (context) => SettingsPage())
    );
  }

  btnFaq(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => FAQScreen()));
  }

}