import 'package:hive/hive.dart';

import '../hive.dart';

part 'progress.g.dart';

@HiveType(typeId: 151)
class ProgressModel {
  @HiveField(0)
  Map<DateTime, int> count_of_session;
  @HiveField(1)
  final Map<DateTime, int> minutes_of_awarenes;
  @HiveField(2)
  final Map<DateTime, int> count_of_complete_session;
  @HiveField(3)
  final Map<DateTime, double> percent_of_awareness;

  ProgressModel({
    this.count_of_session,
    this.minutes_of_awarenes,
    this.count_of_complete_session,
    this.percent_of_awareness,
  });

  ProgressModel get zero => ProgressModel(
        count_of_session: {},
        count_of_complete_session: {},
        minutes_of_awarenes: {},
        percent_of_awareness: {},
      );

  void save() {
    MyDB().saveProgress(this);
  }
}
