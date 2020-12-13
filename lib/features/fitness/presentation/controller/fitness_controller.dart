import 'package:get/get.dart';
import 'package:morningmagic/features/fitness/models/fitness_exercise.dart';
import 'package:morningmagic/features/fitness/models/fitness_program.dart';

class FitnessController extends GetxController {
  Rx<FitnessProgram> _selectedProgram = Rx<FitnessProgram>();

  FitnessProgram get selectedProgram => _selectedProgram.value;

  set selectedProgram(FitnessProgram value) {
    _selectedProgram.value = value;
  }

  final List<FitnessProgram> programs = generateDefaultPrograms().obs;

  FitnessProgram findProgram(FitnessProgram program) {
    return programs.where((element) => element == program).first;
  }

  void deleteProgram(FitnessProgram program) {
    programs.removeWhere((element) => element == program);
  }

  int programIndex(FitnessProgram program) => programs.indexOf(program);

  void addProgram(FitnessProgram program) {
    programs.add(program);
  }

  void updateProgram(FitnessProgram oldProgram, FitnessProgram newProgram) {
    int _index = programIndex(oldProgram);
    programs.replaceRange(_index, _index + 1, [newProgram]);
  }

  void restoreDefaultPrograms() {
    programs.clear();
    programs.addAll(generateDefaultPrograms());
  }

  static List<FitnessProgram> generateDefaultPrograms() => [
        FitnessProgram(
          name: 'Program1',
          isCreatedByUser: false,
          exercises: [
            FitnessExercise(name: 'Потягивания', description: null),
            FitnessExercise(name: 'Ходьба', description: null),
            FitnessExercise(name: 'Взмахи', description: null),
            FitnessExercise(name: 'Прыжки', description: null),
            FitnessExercise(name: 'Шаги на месте', description: null),
          ],
        ),
        FitnessProgram(
          name: 'Program2',
          isCreatedByUser: false,
          exercises: [
            FitnessExercise(name: 'Потягивания', description: null),
            FitnessExercise(name: 'Ходьба', description: null),
            FitnessExercise(name: 'Взмахи', description: null),
            FitnessExercise(name: 'Прыжки', description: null),
            FitnessExercise(name: 'Шаги на месте', description: null),
          ],
        ),
        FitnessProgram(name: 'Program3', isCreatedByUser: false, exercises: [])
      ];
}
