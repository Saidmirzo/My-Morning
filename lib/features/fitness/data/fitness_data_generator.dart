import 'package:morningmagic/features/fitness/domain/entities/exercise/fitness_exercise.dart';
import 'package:morningmagic/features/fitness/domain/entities/program/fitness_program.dart';

class FitnessDataGenerator {
  static List<FitnessProgram> generateDefaultPrograms() => [
        FitnessProgram(
          'program_1',
          isCreatedByUser: false,
          exercises: [
            FitnessExercise(
              'program_1_ex_1_name',
              'program_1_ex_1_desc',
              isCreatedByUser: false,
              audioRes: 'program_1_ex_1_audio',
            ),
            FitnessExercise(
              'program_1_ex_2_name',
              'program_1_ex_2_desc',
              isCreatedByUser: false,
              audioRes: 'program_1_ex_2_audio',
            ),
            FitnessExercise(
              'program_1_ex_3_name',
              'program_1_ex_3_desc',
              isCreatedByUser: false,
              audioRes: 'program_1_ex_3_audio',
            ),
            FitnessExercise(
              'program_1_ex_4_name',
              'program_1_ex_4_desc',
              isCreatedByUser: false,
              audioRes: 'program_1_ex_4_audio',
            ),
            FitnessExercise(
              'program_1_ex_5_name',
              'program_1_ex_5_desc',
              isCreatedByUser: false,
              audioRes: 'program_1_ex_5_audio',
            ),
            FitnessExercise(
              'program_1_ex_6_name',
              'program_1_ex_6_desc',
              isCreatedByUser: false,
              audioRes: 'program_1_ex_6_audio',
            ),
          ],
        ),
        FitnessProgram(
          'program_2',
          isCreatedByUser: false,
          exercises: [
            FitnessExercise(
              'program_2_ex_1_name',
              'program_2_ex_1_desc',
              isCreatedByUser: false,
              audioRes: 'program_2_ex_1_audio',
            ),
            FitnessExercise(
              'program_2_ex_2_name',
              'program_2_ex_2_desc',
              isCreatedByUser: false,
              audioRes: 'program_2_ex_2_audio',
            ),
            FitnessExercise(
              'program_2_ex_3_name',
              'program_2_ex_3_desc',
              isCreatedByUser: false,
              audioRes: 'program_2_ex_3_audio',
            ),
            FitnessExercise(
              'program_2_ex_4_name',
              'program_2_ex_4_desc',
              isCreatedByUser: false,
              audioRes: 'program_2_ex_4_audio',
            ),
            FitnessExercise(
              'program_2_ex_5_name',
              'program_2_ex_5_desc',
              isCreatedByUser: false,
              audioRes: 'program_2_ex_5_audio',
            ),
            FitnessExercise(
              'program_2_ex_6_name',
              'program_2_ex_6_desc',
              isCreatedByUser: false,
              audioRes: 'program_2_ex_6_audio',
            ),
          ],
        ),
        FitnessProgram(
          'program_3',
          isCreatedByUser: false,
          exercises: [
            FitnessExercise(
              'program_3_ex_1_name',
              'program_3_ex_1_desc',
              isCreatedByUser: false,
              audioRes: 'program_3_ex_1_audio',
            ),
            FitnessExercise(
              'program_3_ex_2_name',
              'program_3_ex_2_desc',
              isCreatedByUser: false,
              audioRes: 'program_3_ex_2_audio',
            ),
            FitnessExercise(
              'program_3_ex_3_name',
              'program_3_ex_3_desc',
              isCreatedByUser: false,
              audioRes: 'program_3_ex_3_audio',
            ),
            FitnessExercise(
              'program_3_ex_4_name',
              'program_3_ex_4_desc',
              isCreatedByUser: false,
              audioRes: 'program_3_ex_4_audio',
            ),
            FitnessExercise(
              'program_3_ex_5_name',
              'program_3_ex_5_desc',
              isCreatedByUser: false,
              audioRes: 'program_3_ex_5_audio',
            ),
          ],
        ),
        FitnessProgram(
          'program_4',
          isCreatedByUser: false,
          exercises: [
            FitnessExercise(
              'program_4_ex_1_name',
              'program_4_ex_1_desc',
              isCreatedByUser: false,
              audioRes: 'program_4_ex_1_audio',
            ),
            FitnessExercise(
              'program_4_ex_2_name',
              'program_4_ex_2_desc',
              isCreatedByUser: false,
              audioRes: 'program_4_ex_2_audio',
            ),
            FitnessExercise(
              'program_4_ex_3_name',
              'program_4_ex_3_desc',
              isCreatedByUser: false,
              audioRes: 'program_4_ex_3_audio',
            ),
            FitnessExercise(
              'program_4_ex_4_name',
              'program_4_ex_4_desc',
              isCreatedByUser: false,
              audioRes: 'program_4_ex_4_audio',
            ),
            FitnessExercise(
              'program_4_ex_5_name',
              'program_4_ex_5_desc',
              isCreatedByUser: false,
              audioRes: 'program_4_ex_5_audio',
            ),
            FitnessExercise(
              'program_4_ex_6_name',
              'program_4_ex_6_desc',
              isCreatedByUser: false,
              audioRes: 'program_4_ex_6_audio',
            ),
          ],
        )
      ];

  static List<FitnessExercise> generateDefaultExercises() =>
      generateDefaultPrograms().fold([], (previousValue, element) {
        previousValue.addAll(element.exercises);
        return previousValue;
      });
}
