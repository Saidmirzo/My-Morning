// import 'dart:collection';

// import 'package:morningmagic/db/hive.dart';
// import 'package:morningmagic/db/resource.dart';

// class ProgressUtil {
//   ProgressUtil();

//   Future<HashMap<String, List<Day>>> getDataMap() async {
//     DayHolder dayHolder = myDbBox.get(MyResource.DAYS_HOLDER);
//     List<Day> allDays = dayHolder.listOfDays;
//     List<String> uniqueStrings = getUniqueDayStrings(allDays);
//     print('Progress: $uniqueStrings');
//     HashMap<String, List<Day>> map = getProgressMap(uniqueStrings, allDays);
//     return map;
//   }

//   List<String> getUniqueDayStrings(List<Day> days) {
//     List<String> result = <String>[];
//     for (int i = 0; i < days.length; i++) {
//       Day day = days[i];
//       if (!result.contains(day.date)) {
//         result.add(day.date);
//       }
//     }
//     return result;
//   }

//   List<Day> getDaysByDateString(String date, List<Day> allDays) {
//     List<Day> currentDateExercises = <Day>[];
//     for (int i = 0; i < allDays.length; i++) {
//       if (date == allDays[i].date) {
//         currentDateExercises.add(allDays[i]);
//       }
//     }
//     return currentDateExercises;
//   }

//   HashMap<String, List<Day>> getProgressMap(
//       List<String> uniqueStrings, List<Day> allDays) {
//     HashMap<String, List<Day>> map = new HashMap<String, List<Day>>();

//     for (int i = 0; i < uniqueStrings.length; i++) {
//       map[uniqueStrings[i]] = getDaysByDateString(uniqueStrings[i], allDays);
//     }

//     return map;
//   }
// }
