import 'package:get/get.dart';
import 'package:morningmagic/features/fitness/models/fitness_program.dart';

class FitnessController extends GetxController {
  Rx<FitnessProgram> _selectedProgram = Rx<FitnessProgram>();

  FitnessProgram get selectedProgram => _selectedProgram.value;

  set selectedProgram(FitnessProgram value) {
    _selectedProgram.value = value;
  }
}
