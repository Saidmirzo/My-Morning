import 'package:get/get.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:morningmagic/features/fitness/domain/entities/exercise/fitness_exercise.dart';
part 'fitness_program.g.dart';

@HiveType(typeId: 18)
class FitnessProgram extends Equatable {
  @HiveField(0)
  final String _name;
  @HiveField(1)
  final bool isCreatedByUser;
  @HiveField(2)
  final List<FitnessExercise> exercises;

  const FitnessProgram(this._name,
      {@required this.isCreatedByUser, @required this.exercises});

  String get name {
    if (!isCreatedByUser) {
      return _name.tr;
    } else {
      return _name;
    }
  }

  @override
  List<Object> get props => [_name, isCreatedByUser, exercises];
}
