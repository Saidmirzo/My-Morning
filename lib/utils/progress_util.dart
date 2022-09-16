import 'package:hive/hive.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/model/app_and_custom_exercises/app_exercise_holder.dart';
import 'package:morningmagic/db/model/app_and_custom_exercises/custom_exercise_holder.dart';
import 'package:morningmagic/db/model/app_and_custom_exercises/exercise_name.dart';
import 'package:morningmagic/db/model/exercise/exercise_holder.dart';
import 'package:morningmagic/db/model/exercise/exercise_title.dart';
import 'package:morningmagic/db/model/user_program/user_program.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:random_string/random_string.dart';

class ExerciseUtils {
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
        defaultValue: CustomExerciseHolder(<ExerciseName>[]));
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

  void saveExercisesNames(Box box) {
    AppExerciseHolder appExerciseHolder = box.get(
        MyResource.APP_EXERCISES_HOLDER,
        defaultValue: AppExerciseHolder(<ExerciseName>[]));

    if (appExerciseHolder.list.isEmpty) {
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
    if (holder != null && holder.skipExercises.isNotEmpty) {
      int index = holder.skipExercises.length - 1;
      ExerciseTitle last = holder.skipExercises[index];
      holder.skipExercises.removeAt(index);
      holder.freshExercises.insert(0, last);
    }
  }
}
