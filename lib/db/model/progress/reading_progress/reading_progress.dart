import 'package:hive/hive.dart';
import 'package:morningmagic/db/model/progress/exercise/exercise.dart';

part 'reading_progress.g.dart';

@HiveType(typeId: 15)
class ReadingProgress extends Exercise {
  ReadingProgress(this.book, this.pages, this.sec, {this.isSkip = false});

  @HiveField(0)
  String book;

  @HiveField(1)
  int pages;

  @HiveField(2)
  int sec;

  @HiveField(3)
  bool isSkip;
}
