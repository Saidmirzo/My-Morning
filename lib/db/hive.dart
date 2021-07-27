import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:morningmagic/db/model/app_and_custom_exercises/custom_exercise_holder.dart';
import 'package:morningmagic/db/model/note/note.dart';
import 'package:morningmagic/db/model/progress/reading_progress/reading_progress.dart';
import 'package:morningmagic/db/model/progress/visualization_progress/visualization_progress.dart';
import 'package:morningmagic/db/model/progress/vocabulary_progress/vocabulary_record_progress.dart';
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
import 'model/book/book_adapter.dart';
import 'model/exercise/exercise_holder.dart';
import 'model/exercise/exercise_title.dart';
import 'model/exercise_time/exercise_time_adapter.dart';
import 'model/notepad.dart';
import 'model/progress.dart';
import 'model/progress/affirmation_progress/affirmation_progress.dart';
import 'model/progress/day/day.dart';
import 'model/progress/day/day_holder.dart';
import 'model/progress/fitness_porgress/fitness_progress.dart';
import 'model/progress/meditation_progress/meditation_progress.dart';
import 'model/progress/vocabulary_progress/vocabulary_note_progress.dart';
import 'model/reordering_program/order_holder.dart';
import 'model/reordering_program/order_item.dart';
import 'model/user/user_adapter.dart';
import 'model/user_program/user_program.dart';

Box myDbBox;

class MyDB {
  static final USER = 'user';

  Future<void> initHiveDatabase() async {
    print('initHiveDatabase');

    await Hive.initFlutter();
    Hive.registerAdapter(ReminderModelAdapter());
    Hive.registerAdapter(AffirmationCategoryModelAdapter());
    Hive.registerAdapter(AffirmationTextModelAdapter());
    Hive.registerAdapter(NotepadAdapter());
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(AffirmationTextAdapter());
    Hive.registerAdapter(BookAdapter());
    Hive.registerAdapter(ExerciseTimeAdapter());
    Hive.registerAdapter(VisualizationAdapter());
    Hive.registerAdapter(DayAdapter());
    Hive.registerAdapter(AffirmationProgressAdapter());
    Hive.registerAdapter(MeditationProgressAdapter());
    Hive.registerAdapter(VisualizationProgressAdapter());
    Hive.registerAdapter(FitnessProgressAdapter());
    Hive.registerAdapter(ReadingProgressAdapter());
    Hive.registerAdapter(DayHolderAdapter());
    Hive.registerAdapter(VocabularyNoteProgressAdapter());
    Hive.registerAdapter(VocabularyRecordProgressAdapter());
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
    Hive.registerAdapter(ProgressModelAdapter());

    await this.openMyBox();
  }

  openMyBox() async {
    myDbBox = await Hive.openBox(MyResource.BOX_NAME);
  }

  Box getBox() {
    if (Hive == null) {
      print('Hive == null | need reInit db');
      // await this.initHiveDatabase();
    }
    if (myDbBox == null) {
      print('myDbBox == null | need openBox');
    }
    // print('return myDbBox');
    return myDbBox;
  }

  Future<void> clearWithoutUserName() async {
    await myDbBox.put(MyResource.AFFIRMATION_PROGRESS, []);
    await myDbBox.put(MyResource.FITNESS_PROGRESS, []);
    await myDbBox.put(MyResource.MY_READING_PROGRESS, []);
    await myDbBox.put(MyResource.MY_VISUALISATION_PROGRESS, []);
    await myDbBox.put(MyResource.NOTEPADS, []);
    await myDbBox.put(MyResource.NOTE_KEY, Note(""));
    await myDbBox.put(MyResource.NOTE_COUNT, 0);
    await myDbBox.put(MyResource.MEDITATION_AUDIO_FAVORITE, []);

    saveProgress(ProgressModel().zero);
  }

  ProgressModel getProgress() {
    ProgressModel pgModel = MyDB().getBox().get(
          MyResource.PROGRESS,
          defaultValue: ProgressModel().zero,
        );
    return pgModel;
  }

  void saveProgress(ProgressModel val) {
    MyDB().getBox().put(MyResource.PROGRESS, val);
  }
}
