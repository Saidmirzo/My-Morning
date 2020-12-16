import 'package:morningmagic/features/fitness/domain/entities/program/fitness_program.dart';

abstract class FitnessProgramRepository {
  Future<List<FitnessProgram>> getFitnessPrograms();

  Future<void> saveFitnessPrograms(List<FitnessProgram> programs);

  Future<List<FitnessProgram>> getDefaultFitnessPrograms();
}
