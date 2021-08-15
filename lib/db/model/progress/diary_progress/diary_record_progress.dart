import 'package:hive/hive.dart';
import 'package:morningmagic/db/model/progress/exercise/exercise.dart';

part 'diary_record_progress.g.dart';

@HiveType(typeId: 45)
class DiaryRecordProgress extends Exercise {
  DiaryRecordProgress(this.path, this.sec, this.isSkip);

  @HiveField(0)
  String path;

  @HiveField(1)
  int sec;

  @HiveField(2)
  bool isSkip;
}
