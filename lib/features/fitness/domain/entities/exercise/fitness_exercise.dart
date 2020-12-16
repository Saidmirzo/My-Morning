import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'fitness_exercise.g.dart';

@HiveType(typeId: 19)
class FitnessExercise extends Equatable {
  @HiveField(0)
  final String name;
  @HiveField(2)
  final String description;

  FitnessExercise({@required this.name, @required this.description});

  @override
  List<Object> get props => [name, description];
}
