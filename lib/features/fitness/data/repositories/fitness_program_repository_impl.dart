import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/features/fitness/data/fitness_data_generator.dart';
import 'package:morningmagic/features/fitness/data/models/fitness_programs_model.dart';
import 'package:morningmagic/features/fitness/domain/entities/fitness_program.dart';
import 'package:morningmagic/features/fitness/domain/repositories/fitness_program_repository.dart';

class FitnessProgramRepositoryImpl implements FitnessProgramRepository {
  @override
  Future<List<FitnessProgram>> getFitnessPrograms() async {
    final List<FitnessProgram> result = [];
    final FitnessProgramsModel _programsModel =
        await MyDB().getBox().get(MyResource.FITNESS_PROGRAMS_KEY);

    (_programsModel == null)
        ? result.addAll(FitnessDataGenerator.generateDefaultPrograms())
        : result.addAll(_programsModel.programs);

    return Future.value(result);
  }

  @override
  Future<void> saveFitnessPrograms(List<FitnessProgram> programs) {
    final fitnessProgramModel = FitnessProgramsModel(programs: programs);
    return Future.value(fitnessProgramModel.save());
  }
}
