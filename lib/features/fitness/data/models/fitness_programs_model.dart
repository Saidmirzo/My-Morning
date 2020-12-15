import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:morningmagic/features/fitness/domain/entities/fitness_program.dart';

part 'fitness_programs_model.g.dart';

@HiveType(typeId: 18)
class FitnessProgramsModel extends HiveObject {
  @HiveField(0)
  final List<FitnessProgram> programs;

  FitnessProgramsModel({@required this.programs});
}
