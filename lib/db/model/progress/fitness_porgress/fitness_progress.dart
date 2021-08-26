import 'package:hive/hive.dart';
import 'package:morningmagic/db/model/progress/exercise/exercise.dart';

part 'fitness_progress.g.dart';

@HiveType(typeId: 14)
class FitnessProgress extends Exercise {
  FitnessProgress(this.sec, this.progName, this.text, this.practicId,
      {this.isSkip = false});

  @HiveField(0)
  int sec;

  @HiveField(1)
  String progName;

  @HiveField(2)
  String text;

  @HiveField(3)
  bool isSkip;

  /// Уникальный id практики чтобы в статистике могли сгруппировать
  @HiveField(4)
  String practicId;
}
