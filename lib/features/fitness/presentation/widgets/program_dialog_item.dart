import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:morningmagic/features/fitness/models/fitness_program.dart';
import 'package:morningmagic/features/fitness/presentation/controller/fitness_controller.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/styled_text.dart';
import 'package:morningmagic/resources/colors.dart';

class ProgramDialogItem extends StatelessWidget {
  final FitnessProgram program;

  final VoidCallback onItemSelected;

  const ProgramDialogItem(
      {Key key, @required this.program, @required this.onItemSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FitnessController c = Get.find();

    return GestureDetector(
      onTap: onItemSelected,
      child: Obx(() {
        final _isSelected = c.selectedProgram == program;
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            decoration: BoxDecoration(
                color: _isSelected ? AppColors.PINK : AppColors.LIGHT_VIOLET,
                borderRadius: BorderRadius.all(Radius.circular(40))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: StyledText(
                  program.name,
                  textAlign: TextAlign.center,
                  color: AppColors.WHITE,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
