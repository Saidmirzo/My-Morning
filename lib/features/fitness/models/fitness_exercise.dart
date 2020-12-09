import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class FitnessExercise extends Equatable {
  final String name;
  final String description;

  FitnessExercise({@required this.name, @required this.description});

  @override
  List<Object> get props => [name, description];
}
