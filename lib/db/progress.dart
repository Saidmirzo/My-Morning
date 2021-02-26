import 'dart:collection';

import 'package:morningmagic/db/db_date.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/model/progress/affirmation_progress/affirmation_progress.dart';
import 'package:morningmagic/db/model/progress/day/day.dart';
import 'package:morningmagic/db/model/progress/day/day_holder.dart';
import 'package:morningmagic/db/model/progress/fitness_porgress/fitness_progress.dart';
import 'package:morningmagic/db/model/progress/meditation_progress/meditation_progress.dart';
import 'package:morningmagic/db/model/progress/progress_object.dart';
import 'package:morningmagic/db/model/progress/reading_progress/reading_progress.dart';
import 'package:morningmagic/db/model/progress/visualization_progress/visualization_progress.dart';
import 'package:morningmagic/db/model/progress/vocabulary_progress/vocabulary_record_progress.dart';
import 'package:morningmagic/db/resource.dart';

import 'model/progress/vocabulary_progress/vocabulary_note_progress.dart';

class ProgressUtil {
  ProgressUtil();

  Future<void> updateDayList(Day day) async {
    DayHolder dayHolder = await MyDB()
        .getBox()
        .get(MyResource.DAYS_HOLDER, defaultValue: DayHolder(new List<Day>()));
    print("List before update: " + dayHolder.listOfDays.length.toString());
    dayHolder.listOfDays.add(day);
    print("List after update: " + dayHolder.listOfDays.length.toString());
    myDbBox.put(MyResource.DAYS_HOLDER, dayHolder);
  }

  Day createDay(
      AffirmationProgress affirmationProgress,
      MeditationProgress meditationProgress,
      FitnessProgress fitnessProgress,
      ReadingProgress readingProgress,
      VocabularyNoteProgress vocabularyNoteProgress,
      VocabularyRecordProgress vocabularyRecordProgress,
      VisualizationProgress visualizationProgress) {
    return new Day(
        DBDate().getStringDate(),
        affirmationProgress,
        meditationProgress,
        fitnessProgress,
        readingProgress,
        vocabularyNoteProgress,
        vocabularyRecordProgress,
        visualizationProgress);
  }

  Future<HashMap<String, List<Day>>> getDataMap() async {
    DayHolder dayHolder = myDbBox.get(MyResource.DAYS_HOLDER);
    List<Day> allDays = dayHolder.listOfDays;
    List<String> uniqueStrings = getUniqueDayStrings(allDays);
    print('Progress: ${uniqueStrings}');
    HashMap<String, List<Day>> map = getProgressMap(uniqueStrings, allDays);
    return map;
  }

  List<ProgressObject> createProgressObjectsList(
      HashMap<String, List<Day>> map) {
    List<ProgressObject> list;
    list = map?.entries?.map((e) => ProgressObject(e.key, e.value))?.toList();
    list?.sort();
    return list;
  }

  List<String> getUniqueDayStrings(List<Day> days) {
    List<String> result = new List<String>();
    for (int i = 0; i < days.length; i++) {
      Day day = days[i];
      if (!result.contains(day.date)) {
        result.add(day.date);
      }
    }
    return result;
  }

  List<Day> getDaysByDateString(String date, List<Day> allDays) {
    List<Day> currentDateExercises = new List<Day>();
    for (int i = 0; i < allDays.length; i++) {
      if (date == allDays[i].date) {
        currentDateExercises.add(allDays[i]);
      }
    }
    return currentDateExercises;
  }

  HashMap<String, List<Day>> getProgressMap(
      List<String> uniqueStrings, List<Day> allDays) {
    HashMap<String, List<Day>> map = new HashMap<String, List<Day>>();

    for (int i = 0; i < uniqueStrings.length; i++) {
      map[uniqueStrings[i]] = getDaysByDateString(uniqueStrings[i], allDays);
    }

    return map;
  }
}
