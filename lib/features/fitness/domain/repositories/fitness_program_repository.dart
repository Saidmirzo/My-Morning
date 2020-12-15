import 'package:morningmagic/features/fitness/domain/entities/fitness_program.dart';

abstract class FitnessProgramRepository {
  Future<List<FitnessProgram>> getFitnessPrograms();
  Future<void> saveFitnessPrograms(List<FitnessProgram> programs);
}