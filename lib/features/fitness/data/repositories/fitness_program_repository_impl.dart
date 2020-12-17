import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/features/fitness/data/fitness_data_generator.dart';
import 'package:morningmagic/features/fitness/domain/entities/program/fitness_program.dart';
import 'package:morningmagic/features/fitness/domain/repositories/fitness_program_repository.dart';

class FitnessProgramRepositoryImpl implements FitnessProgramRepository {
  @override
  Future<List<FitnessProgram>> getFitnessPrograms() async {
    final List<FitnessProgram> result = [];
    final _programs =
        await MyDB().getBox().get(MyResource.FITNESS_PROGRAMS_KEY);
    if (_programs == null) {
      result.addAll(FitnessDataGenerator.generateDefaultPrograms());
    } else {
      final List<FitnessProgram> _locallySavedPrograms =
          _programs.cast<FitnessProgram>();
      result.addAll(_locallySavedPrograms);
    }

    return Future.value(result);
  }

  @override
  Future<void> saveFitnessPrograms(List<FitnessProgram> programs) {
    return MyDB().getBox().put(MyResource.FITNESS_PROGRAMS_KEY, programs);
  }

  @override
  Future<List<FitnessProgram>> getDefaultFitnessPrograms() {
    final _defaultPrograms = FitnessDataGenerator.generateDefaultPrograms();
    MyDB().getBox().put(MyResource.FITNESS_PROGRAMS_KEY, _defaultPrograms);
    return Future.value(_defaultPrograms);
  }
}
