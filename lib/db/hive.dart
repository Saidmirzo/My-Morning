// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'package:hive_flutter/hive_flutter.dart';
import 'package:morningmagic/db/model/app_and_custom_exercises/custom_exercise_holder.dart';
import 'package:morningmagic/db/model/note/note.dart';
import 'package:morningmagic/db/model/progress/diary_progress/diary_note_progress.dart';
import 'package:morningmagic/db/model/progress/diary_progress/diary_record_progress.dart';
import 'package:morningmagic/db/model/progress/music_for_cleeping/music_for_skeeping_progress.dart';
import 'package:morningmagic/db/model/progress/reading_progress/reading_progress.dart';
import 'package:morningmagic/db/model/progress/visualization_progress/visualization_progress.dart';
import 'package:morningmagic/db/model/visualization/visualization_adapter.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/features/fitness/domain/entities/exercise/fitness_exercise.dart';
import 'package:morningmagic/features/fitness/domain/entities/program/fitness_program.dart';
import 'package:morningmagic/features/meditation_audio/domain/entities/meditation_audio.dart';
import 'package:morningmagic/features/visualization/domain/entities/target/visualization_target.dart';
import 'package:morningmagic/pages/affirmation/affirmation_dialog/models/affirmation_cat_model.dart';
import 'package:morningmagic/pages/affirmation/affirmation_dialog/models/affirmation_text_model.dart';
import 'package:morningmagic/pages/reminders/models/reminder.dart';
import 'model/affirmation_text/affirmation_text_adapter.dart';
import 'model/app_and_custom_exercises/app_exercise_holder.dart';
import 'model/app_and_custom_exercises/custom_exercise_holder.dart';
import 'model/app_and_custom_exercises/exercise_name.dart';
import 'model/duration_adapter.dart';
import 'model/exercise/exercise_holder.dart';
import 'model/exercise/exercise_title.dart';
import 'model/exercise_time/exercise_time_adapter.dart';
import 'model/notepad.dart';
import 'model/progress/affirmation_progress/affirmation_progress.dart';
import 'model/progress/fitness_porgress/fitness_progress.dart';
import 'model/progress/meditation_progress/meditation_progress.dart';
import 'model/reordering_program/order_holder.dart';
import 'model/reordering_program/order_item.dart';
import 'model/user/user_adapter.dart';
import 'model/user_program/user_program.dart';

Box myDbBox;

class MyDB {
  static const USER = 'user';

  Future<void> initHiveDatabase() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ReminderModelAdapter());
    Hive.registerAdapter(AffirmationCategoryModelAdapter());
    Hive.registerAdapter(AffirmationTextModelAdapter());
    Hive.registerAdapter(NotepadAdapter());
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(AffirmationTextAdapter());
    Hive.registerAdapter(ExerciseTimeAdapter());
    Hive.registerAdapter(VisualizationAdapter());
    Hive.registerAdapter(AffirmationProgressAdapter());
    Hive.registerAdapter(MeditationProgressAdapter());
    Hive.registerAdapter(VisualizationProgressAdapter());
    Hive.registerAdapter(FitnessProgressAdapter());
    Hive.registerAdapter(ReadingProgressAdapter());
    Hive.registerAdapter(NoteAdapter());
    Hive.registerAdapter(ExerciseHolderAdapter());
    Hive.registerAdapter(ExerciseTitleAdapter());
    Hive.registerAdapter(ExerciseNameAdapter());
    Hive.registerAdapter(CustomExerciseHolderAdapter());
    Hive.registerAdapter(AppExerciseHolderAdapter());
    Hive.registerAdapter(OrderItemAdapter());
    Hive.registerAdapter(OrderHolderAdapter());
    Hive.registerAdapter(UserProgramAdapter());
    Hive.registerAdapter(FitnessProgramAdapter());
    Hive.registerAdapter(FitnessExerciseAdapter());
    Hive.registerAdapter(VisualizationTargetAdapter());
    Hive.registerAdapter(MeditationAudioAdapter());
    Hive.registerAdapter(DurationAdapter());
    Hive.registerAdapter(DiaryNoteProgressAdapter());
    Hive.registerAdapter(DiaryRecordProgressAdapter());
    Hive.registerAdapter(MusicForSleepingProgressAdapter());

    try {
      await openMyBox();
    } catch (e) {
      await Hive.deleteBoxFromDisk(MyResource.BOX_NAME);
      await openMyBox();
    }
  }

  openMyBox() async {
    myDbBox = await Hive.openBox(MyResource.BOX_NAME);
  }

  Box getBox() {
    if (Hive == null) {
      // await this.initHiveDatabase();
    }
    if (myDbBox == null) {}
    // print('return myDbBox');
    return myDbBox;
  }

  // Получаем любой журнал
  Map<String, List<dynamic>> getJournalProgress(String journal) {
    try {
      return Map<String, List<dynamic>>.from(
          myDbBox.get(journal, defaultValue: <String, List<dynamic>>{}));
    } catch (e) {
      // Ошиюка будет у старых пользователей из-за другой структуры сохраненных данных
      // По этому удаляем их и начинаем вести статистику заново
      myDbBox.put(journal, <String, List<dynamic>>{});
      return Map<String, List<dynamic>>.from(
          myDbBox.get(journal, defaultValue: <String, List<dynamic>>{}));
    }
  }

  // Получаем журнал дневника
  Map<String, dynamic> getDiaryProgress() {
    return Map<String, dynamic>.from(getBox()
        .get(MyResource.DIARY_JOURNAL, defaultValue: <String, dynamic>{}));
  }

  Future<void> clearWithoutUserName() async {
    // Очищаем весь журнал по всем практикам
    for (var element in [
      MyResource.AFFIRMATION_JOURNAL,
      MyResource.MEDITATION_JOURNAL,
      MyResource.FITNESS_JOURNAL,
      MyResource.READING_JOURNAL,
      MyResource.VISUALISATION_JOURNAL,
      MyResource.FULL_COMPLEX_FINISH,
      MyResource.MEDITATION_NIGHT_JOURNAL,
      MyResource.MUSIC_SLEEPING_NIGHT_JOURNAL,
    ]) {
      myDbBox.put(element, <String, List<dynamic>>{});
    }

    // У дневника сохранение по другому, по этому очищаем так
    myDbBox.put(MyResource.DIARY_JOURNAL, <String, dynamic>{});

    await myDbBox.put(MyResource.MEDITATION_AUDIO_FAVORITE, []);
  }
}
