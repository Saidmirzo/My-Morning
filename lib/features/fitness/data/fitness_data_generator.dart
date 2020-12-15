import 'package:easy_localization/easy_localization.dart';
import 'package:morningmagic/features/fitness/domain/entities/fitness_exercise.dart';
import 'package:morningmagic/features/fitness/domain/entities/fitness_program.dart';

class FitnessDataGenerator {
  static List<FitnessProgram> generateDefaultPrograms() => [
        FitnessProgram(
          name: tr('program_1'),
          isCreatedByUser: false,
          exercises: [
            FitnessExercise(
                name: tr('program_1_ex_1_name'),
                description: tr('program_1_ex_1_desc')),
            FitnessExercise(
                name: tr('program_1_ex_2_name'),
                description: tr('program_1_ex_2_desc')),
            FitnessExercise(
                name: tr('program_1_ex_3_name'),
                description: tr('program_1_ex_3_desc')),
            FitnessExercise(
                name: tr('program_1_ex_4_name'),
                description: tr('program_1_ex_4_desc')),
            FitnessExercise(
                name: tr('program_1_ex_5_name'),
                description: tr('program_1_ex_5_desc')),
            FitnessExercise(
                name: tr('program_1_ex_6_name'),
                description: tr('program_1_ex_6_desc')),
          ],
        ),
        FitnessProgram(
          name: tr('program_2'),
          isCreatedByUser: false,
          exercises: [
            FitnessExercise(
                name: tr('program_2_ex_1_name'),
                description: tr('program_2_ex_1_desc')),
            FitnessExercise(
                name: tr('program_2_ex_2_name'),
                description: tr('program_2_ex_2_desc')),
            FitnessExercise(
                name: tr('program_2_ex_3_name'),
                description: tr('program_2_ex_3_desc')),
            FitnessExercise(
                name: tr('program_2_ex_4_name'),
                description: tr('program_2_ex_4_desc')),
            FitnessExercise(
                name: tr('program_2_ex_5_name'),
                description: tr('program_2_ex_5_desc')),
            FitnessExercise(
                name: tr('program_2_ex_6_name'),
                description: tr('program_2_ex_6_desc')),
          ],
        ),
        FitnessProgram(
          name: tr('program_3'),
          isCreatedByUser: false,
          exercises: [
            FitnessExercise(
                name: tr('program_3_ex_1_name'),
                description: tr('program_3_ex_1_desc')),
            FitnessExercise(
                name: tr('program_3_ex_2_name'),
                description: tr('program_3_ex_2_desc')),
            FitnessExercise(
                name: tr('program_3_ex_3_name'),
                description: tr('program_3_ex_3_desc')),
            FitnessExercise(
                name: tr('program_3_ex_4_name'),
                description: tr('program_3_ex_4_desc')),
            FitnessExercise(
                name: tr('program_3_ex_5_name'),
                description: tr('program_3_ex_5_desc')),
          ],
        ),
        FitnessProgram(
          name: tr('program_4'),
          isCreatedByUser: false,
          exercises: [
            FitnessExercise(
                name: tr('program_4_ex_1_name'),
                description: tr('program_4_ex_1_desc')),
            FitnessExercise(
                name: tr('program_4_ex_2_name'),
                description: tr('program_4_ex_2_desc')),
            FitnessExercise(
                name: tr('program_4_ex_3_name'),
                description: tr('program_4_ex_3_desc')),
            FitnessExercise(
                name: tr('program_4_ex_4_name'),
                description: tr('program_4_ex_4_desc')),
            FitnessExercise(
                name: tr('program_4_ex_5_name'),
                description: tr('program_4_ex_5_desc')),
            FitnessExercise(
                name: tr('program_4_ex_6_name'),
                description: tr('program_4_ex_6_desc')),
          ],
        )
      ];

  static List<FitnessExercise> generateDefaultExercises() => [
        FitnessExercise(
            name: tr('program_1_ex_1_name'),
            description: tr('program_1_ex_1_desc')),
        FitnessExercise(
            name: tr('program_1_ex_2_name'),
            description: tr('program_1_ex_2_desc')),
        FitnessExercise(
            name: tr('program_1_ex_3_name'),
            description: tr('program_1_ex_3_desc')),
        FitnessExercise(
            name: tr('program_1_ex_4_name'),
            description: tr('program_1_ex_4_desc')),
        FitnessExercise(
            name: tr('program_1_ex_5_name'),
            description: tr('program_1_ex_5_desc')),
        FitnessExercise(
            name: tr('program_1_ex_6_name'),
            description: tr('program_1_ex_6_desc')),
        FitnessExercise(
            name: tr('program_2_ex_1_name'),
            description: tr('program_2_ex_1_desc')),
        FitnessExercise(
            name: tr('program_2_ex_2_name'),
            description: tr('program_2_ex_2_desc')),
        FitnessExercise(
            name: tr('program_2_ex_3_name'),
            description: tr('program_2_ex_3_desc')),
        FitnessExercise(
            name: tr('program_2_ex_4_name'),
            description: tr('program_2_ex_4_desc')),
        FitnessExercise(
            name: tr('program_2_ex_5_name'),
            description: tr('program_2_ex_5_desc')),
        FitnessExercise(
            name: tr('program_2_ex_6_name'),
            description: tr('program_2_ex_6_desc')),
        FitnessExercise(
            name: tr('program_3_ex_1_name'),
            description: tr('program_3_ex_1_desc')),
        FitnessExercise(
            name: tr('program_3_ex_2_name'),
            description: tr('program_3_ex_2_desc')),
        FitnessExercise(
            name: tr('program_3_ex_3_name'),
            description: tr('program_3_ex_3_desc')),
        FitnessExercise(
            name: tr('program_3_ex_4_name'),
            description: tr('program_3_ex_4_desc')),
        FitnessExercise(
            name: tr('program_3_ex_5_name'),
            description: tr('program_3_ex_5_desc')),
        FitnessExercise(
            name: tr('program_4_ex_1_name'),
            description: tr('program_4_ex_1_desc')),
        FitnessExercise(
            name: tr('program_4_ex_2_name'),
            description: tr('program_4_ex_2_desc')),
        FitnessExercise(
            name: tr('program_4_ex_3_name'),
            description: tr('program_4_ex_3_desc')),
        FitnessExercise(
            name: tr('program_4_ex_4_name'),
            description: tr('program_4_ex_4_desc')),
        FitnessExercise(
            name: tr('program_4_ex_5_name'),
            description: tr('program_4_ex_5_desc')),
        FitnessExercise(
            name: tr('program_4_ex_6_name'),
            description: tr('program_4_ex_6_desc')),
      ];
}
