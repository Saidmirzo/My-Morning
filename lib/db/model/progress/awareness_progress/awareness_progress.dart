// ignore_for_file: constant_identifier_names

import 'package:hive/hive.dart';

part 'awareness_progress.g.dart';

const int AWARENESS_PROGRESS_PERCENTS = 3;

@HiveType(typeId: 16)
class AwarenessProgress extends HiveObject {
  @HiveField(0)
  int _awareness;

  int get awareness => _awareness ?? 0;

  @HiveField(1)
  DateTime _lastUpdateDate;

  bool get isLastUpdateToday {
    if (_lastUpdateDate == null) return false;
    var now = DateTime.now();
    return now.year == _lastUpdateDate.year &&
        now.month == _lastUpdateDate.month &&
        now.day == _lastUpdateDate.day;
  }

  void incrementAwareness() {
    if (_awareness >= 100 || isLastUpdateToday) {
      return;
    } else {
      _awareness += AWARENESS_PROGRESS_PERCENTS;
      _lastUpdateDate = DateTime.now();
    }
  }

  AwarenessProgress(this._awareness);
}
