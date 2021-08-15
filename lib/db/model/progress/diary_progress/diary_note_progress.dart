import 'package:hive/hive.dart';
import 'package:morningmagic/db/model/progress/exercise/exercise.dart';

part 'diary_note_progress.g.dart';

@HiveType(typeId: 35)
class DiaryNoteProgress extends Exercise {
  DiaryNoteProgress(this.note, this.sec, this.isSkip);

  @HiveField(0)
  String note;

  @HiveField(1)
  int sec;

  @HiveField(2)
  bool isSkip;
}
