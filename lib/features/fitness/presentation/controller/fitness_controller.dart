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

  void deleteProgram(FitnessProgram program) {
    programs.removeWhere((element) => element == program);
  }

  void restoreDefaultPrograms() {
    programs.clear();
    programs.addAll(generateDefaultPrograms());
  }

  static List<FitnessProgram> generateDefaultPrograms() => [
        FitnessProgram(
          name:
              'Program1 df dfdfdfdfkd;lfkd;lfk;d dfdfdkljfldkjfdklfj dkjfdkljfldkj',
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
