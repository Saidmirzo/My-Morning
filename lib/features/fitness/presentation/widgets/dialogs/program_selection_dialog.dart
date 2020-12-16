import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/features/fitness/presentation/controller/fitness_controller.dart';
import 'package:morningmagic/features/fitness/presentation/pages/exercise_page.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/dialog_header_button.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/program_dialog_item.dart';
import 'package:morningmagic/resources/colors.dart';

import '../styled_text.dart';

class ProgramSelectionDialog extends StatelessWidget {
  final _fitnessController = Get.find<FitnessController>();

  @override
  Widget build(BuildContext context) {
    _fitnessController.step = 0;

    final _programs = _fitnessController.programs
        .where((program) => program.exercises.isNotEmpty)
        .toList();

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Container(
        height: MediaQuery.of(context).size.height / 1.3,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 8,
              ),
              DialogHeaderButton(
                  text: 'назад', onTap: () => Navigator.pop(context)),
              SizedBox(
                height: 8,
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _programs.length,
                  itemBuilder: (context, index) => ProgramDialogItem(
                    program: _programs[index],
                    onItemSelected: () {
                      final FitnessController c = Get.find();
                      c.selectedProgram = _programs[index];
                    },
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Obx(() {
                  bool _isActive = _fitnessController.selectedProgram != null;
                  return InkWell(
                    onTap:
                        _isActive ? () => navigateProgramScreen(context) : null,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 12.0),
                      child: StyledText('Начать',
                          textAlign: TextAlign.center,
                          fontSize: 23,
                          color: _isActive
                              ? AppColors.VIOLET
                              : AppColors.VIOLET.withAlpha(70)),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void navigateProgramScreen(BuildContext context) async {
    // TODO remove old
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) =>
    //             ExerciseDetails(stepId: 0, isCustomProgram: false, pageId: 0)));

    final _step = _fitnessController.step;
    final _exercise = _fitnessController.currentExercise;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ExercisePage(
                  exercise: _exercise,
                  step: _step,
                )));
    _fitnessController.incrementStep();
  }
}
