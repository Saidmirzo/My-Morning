import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:morningmagic/features/fitness/domain/entities/exercise/fitness_exercise.dart';

part 'fitness_program.g.dart';

@HiveType(typeId: 18)
class FitnessProgram extends Equatable {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final bool isCreatedByUser;
  @HiveField(2)
  final List<FitnessExercise> exercises;

  FitnessProgram(
      {@required this.name,
      @required this.isCreatedByUser,
      @required this.exercises});

  @override
  List<Object> get props => [name, isCreatedByUser, exercises];
}
