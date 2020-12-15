import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:morningmagic/features/fitness/domain/entities/fitness_program.dart';
import 'package:morningmagic/features/fitness/domain/repositories/fitness_program_repository.dart';

class FitnessController extends GetxController {
  final FitnessProgramRepository repository;

  Rx<FitnessProgram> _selectedProgram = Rx<FitnessProgram>();

  FitnessController({@required this.repository});

  FitnessProgram get selectedProgram => _selectedProgram.value;

  set selectedProgram(FitnessProgram value) {
    _selectedProgram.value = value;
  }

  final programs = <FitnessProgram>[].obs;

  @override
  void onInit() async {
    super.onInit();
    final _result = await repository.getFitnessPrograms();
    programs.addAll(_result);
  }

  FitnessProgram findProgram(FitnessProgram program) {
    return programs.where((element) => element == program).first;
  }

  void deleteProgram(FitnessProgram program) {
    // TODO delete program
    programs.removeWhere((element) => element == program);

  }

  int programIndex(FitnessProgram program) => programs.indexOf(program);

  void addProgram(FitnessProgram program) async {
    programs.add(program);
    await repository.saveFitnessPrograms(programs.value);
  }

  // TODO make update program
  void updateProgram(FitnessProgram oldProgram, FitnessProgram newProgram) {
    int _index = programIndex(oldProgram);
    programs.replaceRange(_index, _index + 1, [newProgram]);
  }

  // TODO make restore programs
  void restoreDefaultPrograms() async {
    programs.clear();
    programs.addAll(await repository.getFitnessPrograms());
  }
}
