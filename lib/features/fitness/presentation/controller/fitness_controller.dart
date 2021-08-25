import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:morningmagic/features/fitness/domain/entities/exercise/fitness_exercise.dart';
import 'package:morningmagic/features/fitness/domain/entities/program/fitness_program.dart';
import 'package:morningmagic/features/fitness/domain/repositories/fitness_program_repository.dart';

class FitnessController extends GetxController {
  final FitnessProgramRepository repository;
  final bool fromHomeMenu;

  FitnessController({@required this.repository, this.fromHomeMenu = false});

  @override
  void onInit() async {
    super.onInit();
    final _result = await repository.getFitnessPrograms();
    programs.addAll(_result);
    print('FitnessController fromHomeMenu : $fromHomeMenu');
  }

  Rx<FitnessProgram> _selectedProgram = Rx<FitnessProgram>();

  FitnessProgram get selectedProgram => _selectedProgram.value;

  set selectedProgram(FitnessProgram value) {
    print('selectedProgram ${value.exercises.length}');
    _selectedProgram.value = value;
  }

  final programs = <FitnessProgram>[].obs;

  int programIndex(FitnessProgram program) => programs.indexOf(program);

  int step = 0;

  void incrementStep() => step++;
  void dicrementStep() => step--;

  FitnessExercise get currentExercise {
    if (selectedProgram == null || selectedProgram.exercises.isEmpty)
      return null;
    else {
      if (step >= selectedProgram.exercises.length)
        return null;
      else
        return selectedProgram.exercises[step];
    }
  }

  FitnessExercise get prevExercise {
    if (selectedProgram == null || selectedProgram.exercises.isEmpty)
      return null;
    else {
      if (step < 0)
        return null;
      else
        return selectedProgram.exercises[step];
    }
  }

  FitnessProgram findProgram(FitnessProgram program) {
    return programs.where((element) => element == program).first;
  }

  void deleteProgram(FitnessProgram program) async {
    programs.removeWhere((element) => element == program);
    repository.saveFitnessPrograms(programs);
  }

  void addProgram(FitnessProgram program) {
    programs.add(program);
    repository.saveFitnessPrograms(programs);
  }

  void updateProgram(FitnessProgram oldProgram, FitnessProgram newProgram) {
    int _index = programIndex(oldProgram);
    programs.replaceRange(_index, _index + 1, [newProgram]);
    repository.saveFitnessPrograms(programs);
  }

  void restoreDefaultPrograms() async {
    programs.clear();
    programs.addAll(await repository.getDefaultFitnessPrograms());
  }
}
