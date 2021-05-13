import 'package:hive/hive.dart';

part 'reminder.g.dart';

@HiveType(typeId: 155)
class ReminderModel {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final DateTime date;
  @HiveField(2)
  final String text;
  @HiveField(3)
  bool isActive;
  @HiveField(4)
  final List<int> activeDays;

  ReminderModel({
    this.id,
    this.date,
    this.text = '',
    this.isActive = true,
    this.activeDays,
  });
}
