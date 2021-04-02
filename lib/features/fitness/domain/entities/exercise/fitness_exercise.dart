import 'package:get/get.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'fitness_exercise.g.dart';

@HiveType(typeId: 19)
class FitnessExercise extends Equatable {
  @HiveField(0)
  final String _name;
  @HiveField(1)
  final String _description;
  @HiveField(2)
  final bool isCreatedByUser;
  @HiveField(3)
  final String audioRes;
  @HiveField(4)
  final String imageRes;

  FitnessExercise(this._name, this._description,
      {this.isCreatedByUser = false, this.audioRes, this.imageRes});

  String get name {
    if (!this.isCreatedByUser)
      return _name.tr;
    else
      return _name;
  }

  String get description {
    if (!this.isCreatedByUser)
      return _description.tr;
    else
      return _description;
  }

  @override
  List<Object> get props => [_name, _description, isCreatedByUser];
}
