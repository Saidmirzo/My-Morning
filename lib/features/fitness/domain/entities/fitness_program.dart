import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:morningmagic/features/fitness/domain/entities/fitness_exercise.dart';

class FitnessProgram extends Equatable {
  final String name;
  final bool isCreatedByUser;
  final List<FitnessExercise> exercises;

  FitnessProgram(
      {@required this.name,
      @required this.isCreatedByUser,
      @required this.exercises});

  @override
  List<Object> get props => [name, isCreatedByUser, exercises];
}
