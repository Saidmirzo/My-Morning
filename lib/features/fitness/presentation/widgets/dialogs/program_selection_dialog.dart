import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/features/fitness/presentation/controller/fitness_controller.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/dialog_action_button.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/program_dialog_item.dart';
import 'package:morningmagic/pages/exerciseDetails.dart';
import 'package:morningmagic/resources/colors.dart';

import '../styled_text.dart';

class ProgramSelectionDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _fitnessController = Get.find<FitnessController>();
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
              DialogActionButton(
                  text: 'назад', onTap: () => Navigator.pop(context)),
              SizedBox(
                height: 8,
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _fitnessController.programs.length,
                  itemBuilder: (context, index) => ProgramDialogItem(
                    program: _fitnessController.programs[index],
                    onItemSelected: () {
                      final FitnessController c = Get.find();
                      c.selectedProgram = _fitnessController.programs[index];
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

  void navigateProgramScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ExerciseDetails(
                stepId: 0, isCustomProgramm: false, pageId: 0)));
  }
}
