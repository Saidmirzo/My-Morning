import 'package:hive/hive.dart';

part 'affirmation_model.g.dart';

@HiveType(typeId: 154)
class AffirmationyModel {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final bool isCustom;
  @HiveField(2)
  final List<String> affirmations;

  AffirmationyModel({this.name, this.isCustom = false, this.affirmations});
}
