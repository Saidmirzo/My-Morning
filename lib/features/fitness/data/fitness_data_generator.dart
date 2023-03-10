import 'package:get/get.dart';
import 'package:morningmagic/features/fitness/domain/entities/exercise/fitness_exercise.dart';
import 'package:morningmagic/features/fitness/domain/entities/program/fitness_program.dart';

class FitnessDataGenerator {
  static const String imgPath = 'assets/images/fitnes/ex';
  static List<FitnessProgram> generateDefaultPrograms() => [
        FitnessProgram(
          'program_1',
          isCreatedByUser: false,
          exercises: [
            FitnessExercise(
              'program_1_ex_1_name',
              'program_1_ex_1_desc',
              imageRes: '$imgPath/program_1/program_1_ex_1_img.png',
              audioRes: 'program_1_ex_1_audio'.tr,
            ),
            FitnessExercise(
              'program_1_ex_2_name',
              'program_1_ex_2_desc',
              imageRes: '$imgPath/program_1/program_1_ex_2_img.png',
              audioRes: 'program_1_ex_2_audio'.tr,
            ),
            FitnessExercise(
              'program_1_ex_3_name',
              'program_1_ex_3_desc',
              imageRes: '$imgPath/program_1/program_1_ex_3_img.png',
              audioRes: 'program_1_ex_3_audio'.tr,
            ),
            FitnessExercise(
              'program_1_ex_4_name',
              'program_1_ex_4_desc',
              imageRes: '$imgPath/program_1/program_1_ex_4_img.png',
              audioRes: 'program_1_ex_4_audio'.tr,
            ),
            FitnessExercise(
              'program_1_ex_5_name',
              'program_1_ex_5_desc',
              imageRes: '$imgPath/program_1/program_1_ex_5_img.png',
              audioRes: 'program_1_ex_5_audio'.tr,
            ),
            FitnessExercise(
              'program_1_ex_6_name',
              'program_1_ex_6_desc',
              imageRes: '$imgPath/program_1/program_1_ex_6_img.png',
              audioRes: 'program_1_ex_6_audio'.tr,
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
              imageRes: '$imgPath/program_2/program_2_ex_1.png',
              audioRes: 'program_2_ex_1_audio'.tr,
            ),
            FitnessExercise(
              'program_2_ex_2_name',
              'program_2_ex_2_desc',
              imageRes: '$imgPath/program_2/program_2_ex_2.png',
              audioRes: 'program_2_ex_2_audio'.tr,
            ),
            FitnessExercise(
              'program_2_ex_3_name',
              'program_2_ex_3_desc',
              imageRes: '$imgPath/program_2/program_2_ex_3.gif',
              audioRes: 'program_2_ex_3_audio'.tr,
            ),
            FitnessExercise(
              'program_2_ex_4_name',
              'program_2_ex_4_desc',
              imageRes: '$imgPath/program_2/program_2_ex_4.gif',
              audioRes: 'program_2_ex_4_audio'.tr,
            ),
            FitnessExercise(
              'program_2_ex_5_name',
              'program_2_ex_5_desc',
              imageRes: '$imgPath/program_2/program_2_ex_5.gif',
              audioRes: 'program_2_ex_5_audio'.tr,
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
              imageRes: '$imgPath/program_3/program_3_ex_1.png',
              audioRes: 'program_3_ex_1_audio'.tr,
            ),
            FitnessExercise(
              'program_3_ex_2_name',
              'program_3_ex_2_desc',
              imageRes: '$imgPath/program_3/program_3_ex_2.gif',
              audioRes: 'program_3_ex_2_audio'.tr,
            ),
            FitnessExercise(
              'program_3_ex_3_name',
              'program_3_ex_3_desc',
              imageRes: '$imgPath/program_3/program_3_ex_3.gif',
              audioRes: 'program_3_ex_3_audio'.tr,
            ),
            FitnessExercise(
              'program_3_ex_4_name',
              'program_3_ex_4_desc',
              imageRes: '$imgPath/program_3/program_3_ex_4.gif',
              audioRes: 'program_3_ex_4_audio'.tr,
            ),
            FitnessExercise(
              'program_3_ex_5_name',
              'program_3_ex_5_desc',
              imageRes: '$imgPath/program_3/program_3_ex_5.gif',
              audioRes: 'program_3_ex_5_audio'.tr,
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
              imageRes: '$imgPath/program_4/program_4_ex_1.gif',
              audioRes: 'program_4_ex_1_audio'.tr,
            ),
            FitnessExercise(
              'program_4_ex_2_name',
              'program_4_ex_2_desc',
              imageRes: '$imgPath/program_4/program_4_ex_2.gif',
              audioRes: 'program_4_ex_2_audio'.tr,
            ),
            FitnessExercise(
              'program_4_ex_3_name',
              'program_4_ex_3_desc',
              imageRes: '$imgPath/program_4/program_4_ex_3.gif',
              audioRes: 'program_4_ex_3_audio'.tr,
            ),
            FitnessExercise(
              'program_4_ex_4_name',
              'program_4_ex_4_desc',
              imageRes: '$imgPath/program_4/program_4_ex_4.png',
              audioRes: 'program_4_ex_4_audio'.tr,
            ),
            FitnessExercise(
              'program_4_ex_5_name',
              'program_4_ex_5_desc',
              imageRes: '$imgPath/program_4/program_4_ex_5.gif',
              audioRes: 'program_4_ex_5_audio'.tr,
            ),
            FitnessExercise(
              'program_4_ex_6_name',
              'program_4_ex_6_desc',
              imageRes: '$imgPath/program_4/program_4_ex_6.gif',
              audioRes: 'program_4_ex_6_audio'.tr,
            ),
          ],
        ),
      ];

  static List<FitnessExercise> generateDefaultExercises() =>
      generateDefaultPrograms().fold([], (previousValue, element) {
        previousValue.addAll(element.exercises);
        return previousValue;
      });
}
