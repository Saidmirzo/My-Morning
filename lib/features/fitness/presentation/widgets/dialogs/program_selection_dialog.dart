import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:morningmagic/features/fitness/presentation/controller/fitness_controller.dart';
import 'package:morningmagic/features/fitness/presentation/pages/exercise_page.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/dialog_header_button.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/program_dialog_item.dart';
import 'package:morningmagic/resources/colors.dart';
import '../styled_text.dart';

class ProgramSelectionDialog extends StatelessWidget {
  final _fitnessController = Get.find<FitnessController>();

  ProgramSelectionDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _programs = _fitnessController.programs
        .where((program) => program.exercises.isNotEmpty)
        .toList();

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 1.3,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 8,
              ),
              DialogHeaderButton(
                  text: 'back_button'.tr, onTap: () => Navigator.pop(context)),
              const SizedBox(
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
                      child: StyledText('start'.tr,
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
    _fitnessController.step = 0;
    final _exercise = _fitnessController.currentExercise;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ExercisePage(
                _fitnessController.selectedProgram.name, _exercise)));
  }
}
