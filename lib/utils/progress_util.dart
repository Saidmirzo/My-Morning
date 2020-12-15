import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/model/app_and_custom_exercises/app_exercise_holder.dart';
import 'package:morningmagic/db/model/app_and_custom_exercises/custom_exercise_holder.dart';
import 'package:morningmagic/db/model/app_and_custom_exercises/exercise_name.dart';
import 'package:morningmagic/db/model/exercise/exercise_holder.dart';
import 'package:morningmagic/db/model/exercise/exercise_title.dart';
import 'package:morningmagic/db/model/progress/day/day.dart';
import 'package:morningmagic/db/model/progress/day/day_holder.dart';
import 'package:morningmagic/db/model/user_program/user_program.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/pages/exerciseCustomDetails.dart';
import 'package:morningmagic/pages/exerciseDetails.dart';
import 'package:morningmagic/pages/success/screenTimerSuccess.dart';
import 'package:morningmagic/utils/reordering_util.dart';
import 'package:random_string/random_string.dart';

class ExerciseUtils {
  void chooseExerciseAndRoute(
      BuildContext context, String exerciseName, int pageId) {
    if (equalsIgnoreCase(exerciseName, "Потягивания") ||
        equalsIgnoreCase(exerciseName, "Stretching")) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ExerciseDetails(
                  stepId: 0, pageId: pageId, isCustomProgram: true)));
    } else if (equalsIgnoreCase(exerciseName, "Шаги на месте") ||
        equalsIgnoreCase(exerciseName, "March in Place")) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ExerciseDetails(
                  stepId: 1, pageId: pageId, isCustomProgram: true)));
    } else if (equalsIgnoreCase(exerciseName, "Перекаты с носков на пятки") ||
        equalsIgnoreCase(exerciseName, "Heel and Toe Raises")) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ExerciseDetails(
                  stepId: 2, pageId: pageId, isCustomProgram: true)));
    } else if (equalsIgnoreCase(exerciseName, "Вращения") ||
        equalsIgnoreCase(exerciseName, "Rotations")) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ExerciseDetails(
                  stepId: 3, pageId: pageId, isCustomProgram: true)));
    } else if (equalsIgnoreCase(
            exerciseName, "Попеременные наклоны и приседания") ||
        equalsIgnoreCase(exerciseName, "Alternating bend and squats")) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ExerciseDetails(
                  stepId: 4, pageId: pageId, isCustomProgram: true)));
    } else if (equalsIgnoreCase(exerciseName, "Наклоны в стороны") ||
        equalsIgnoreCase(exerciseName, "Standing Side Bend")) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ExerciseDetails(
                  stepId: 5, pageId: pageId, isCustomProgram: true)));
    } else if (equalsIgnoreCase(
            exerciseName, "Попеременное подтягивание ног") ||
        equalsIgnoreCase(exerciseName, "Bicycle Crunch")) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ExerciseDetails(
                  stepId: 6, pageId: pageId, isCustomProgram: true)));
    } else if (equalsIgnoreCase(exerciseName, "«Кошечка»") ||
        equalsIgnoreCase(exerciseName, "Cat and Dog")) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ExerciseDetails(
                  stepId: 7, pageId: pageId, isCustomProgram: true)));
    } else if (equalsIgnoreCase(exerciseName, "Отжимания") ||
        equalsIgnoreCase(exerciseName, "Press Up")) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ExerciseDetails(
                  stepId: 8, pageId: pageId, isCustomProgram: true)));
    } else if (equalsIgnoreCase(exerciseName, "Потягивания ") ||
        equalsIgnoreCase(exerciseName, "Hand stretching")) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ExerciseDetails(
                  stepId: 9, pageId: pageId, isCustomProgram: true)));
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ExerciseCustomDetails(title: exerciseName, pageId: pageId)));
      print("Custom user exercise !!!");
    }
  }

  Future<void> deleteAllProgress() async {
    await MyDB().getBox().put(MyResource.DAYS_HOLDER, DayHolder(List<Day>()));
  }

  Future<void> deleteSelectedExerciseFromDB(String key) async {
    ExerciseHolder holder =
        await MyDB().getBox().get(MyResource.EXERCISES_HOLDER);
    if (holder != null) removeItem(holder, key);
    await MyDB().getBox().put(MyResource.EXERCISES_HOLDER, holder);
  }

  Future<void> deleteSelectedExerciseProgramFromDB(String key) async {
    UserProgram program =
        await MyDB().getBox().get(MyResource.USER_PROGRAM_HOLDER);
    if (program != null) {
      removeItemProgram(program, key);
    }
    await MyDB().getBox().put(MyResource.USER_PROGRAM_HOLDER, program);
  }

  void removeItemProgram(UserProgram program, String key) {
    for (int i = 0; i < program.exercises.length; i++) {
      if (key == program.exercises[i].key) {
        program.exercises.removeAt(i);
        break;
      }
    }
  }

  void removeItem(ExerciseHolder holder, String key) {
    for (int i = 0; i < holder.freshExercises.length; i++) {
      if (key == holder.freshExercises[i].key) {
        holder.freshExercises.removeAt(i);
        break;
      }
    }
  }

  Future<void> saveCustomExerciseToDB(ExerciseName exerciseName) async {
    saveCustomExercise(exerciseName);
  }

  void saveCustomExercise(ExerciseName exerciseName) async {
    CustomExerciseHolder customExerciseHolder = await MyDB().getBox().get(
        MyResource.CUSTOM_EXERCISES_HOLDER,
        defaultValue: CustomExerciseHolder(List<ExerciseName>()));
    customExerciseHolder.list.add(exerciseName);
    await MyDB()
        .getBox()
        .put(MyResource.CUSTOM_EXERCISES_HOLDER, customExerciseHolder);
  }

  Future<void> deleteCustomExerciseFromDB(ExerciseName exerciseName) async {
    deleteCustomExercise(exerciseName);
  }

  void deleteCustomExercise(ExerciseName exerciseName) async {
    CustomExerciseHolder customExerciseHolder =
        await MyDB().getBox().get(MyResource.CUSTOM_EXERCISES_HOLDER);
    if (customExerciseHolder != null) {
      for (int i = 0; i < customExerciseHolder.list.length; i++) {
        if (customExerciseHolder.list[i].id == exerciseName.id) {
          customExerciseHolder.list.removeAt(i);
          break;
        }
      }
    }
    await MyDB()
        .getBox()
        .put(MyResource.CUSTOM_EXERCISES_HOLDER, customExerciseHolder);
  }

  void goNextRoute(BuildContext context, int pageId) async {
    nextRoute(context, pageId);
  }

  void saveExercisesNames(Box box) {
    AppExerciseHolder appExerciseHolder = box.get(
        MyResource.APP_EXERCISES_HOLDER,
        defaultValue: AppExerciseHolder(List<ExerciseName>()));

    if (appExerciseHolder.list.length == 0) {
      appExerciseHolder.list
          .add(ExerciseName(randomAlpha(10), "exercise_1_title", 14));
      appExerciseHolder.list
          .add(ExerciseName(randomAlpha(10), "exercise_2_title", 14));
      appExerciseHolder.list
          .add(ExerciseName(randomAlpha(10), "exercise_3_title", 11));
      appExerciseHolder.list
          .add(ExerciseName(randomAlpha(10), "exercise_4_title", 14));
      appExerciseHolder.list
          .add(ExerciseName(randomAlpha(10), "exercise_5_title", 11));
      appExerciseHolder.list
          .add(ExerciseName(randomAlpha(10), "exercise_6_title", 11));
      appExerciseHolder.list
          .add(ExerciseName(randomAlpha(10), "exercise_7_title", 11));
      appExerciseHolder.list
          .add(ExerciseName(randomAlpha(10), "exercise_8_title", 14));
      appExerciseHolder.list
          .add(ExerciseName(randomAlpha(10), "exercise_9_title", 14));
      appExerciseHolder.list
          .add(ExerciseName(randomAlpha(10), "exercise_10_title", 14));

      print("APP EXERCISES SAVED !!!");

      box.put(MyResource.APP_EXERCISES_HOLDER, appExerciseHolder);
      print(box.get(MyResource.APP_EXERCISES_HOLDER));
    }
  }

  void goPreviousRoute() async {
    moveRouteToFresh();
  }

  void moveRouteToFresh() async {
    ExerciseHolder holder =
        await MyDB().getBox().get(MyResource.EXERCISES_HOLDER);
    if (holder != null && holder.skipExercises.length > 0) {
      int index = holder.skipExercises.length - 1;
      ExerciseTitle last = holder.skipExercises[index];
      holder.skipExercises.removeAt(index);
      holder.freshExercises.insert(0, last);
    }
  }

  void nextRoute(BuildContext context, int pageId) async {
    ExerciseHolder holder =
        await MyDB().getBox().get(MyResource.EXERCISES_HOLDER);
    if (holder != null && holder.freshExercises.length > 0) {
      ExerciseTitle first = holder.freshExercises.first;
      holder.freshExercises.removeAt(0);
      holder.skipExercises.add(first);

      await MyDB().getBox().put(MyResource.EXERCISES_HOLDER, holder);

      chooseExerciseAndRoute(context, first.title, pageId);
    } else if (holder != null &&
        holder.freshExercises.length == 0 &&
        holder.skipExercises.length > 0) {
      OrderUtil().getRouteById(2).then((value) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TimerSuccessScreen(() {
                      Navigator.push(context, value);
                    }, MyDB().getBox().get(MyResource.FITNESS_TIME_KEY).time,
                        false)));
      });
    }
  }

  bool equalsIgnoreCase(String a, String b) =>
      (a == null && b == null) ||
      (a != null && b != null && a.toLowerCase() == b.toLowerCase());
}
