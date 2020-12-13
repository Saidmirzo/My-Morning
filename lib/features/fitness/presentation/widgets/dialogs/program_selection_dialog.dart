import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/features/fitness/models/fitness_program.dart';
import 'package:morningmagic/features/fitness/presentation/controller/fitness_controller.dart';
import 'package:morningmagic/pages/exerciseDetails.dart';
import 'package:morningmagic/resources/colors.dart';

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
              Row(
                children: [
                  // TODO move to widget
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 12.0),
                      child: Text(
                        'назад',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 23,
                            fontFamily: 'rex',
                            fontStyle: FontStyle.normal,
                            color: AppColors.VIOLET),
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _fitnessController.programs.length,
                  itemBuilder: (context, index) => FitnessProgramDialogItem(
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
                      child: Text(
                        'Начать',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 23,
                            fontFamily: 'rex',
                            fontStyle: FontStyle.normal,
                            color: _isActive
                                ? AppColors.VIOLET
                                : AppColors.VIOLET.withAlpha(70)),
                      ),
                    ),
                  );
                }),
              )
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

class FitnessProgramDialogItem extends StatelessWidget {
  final FitnessProgram program;

  final VoidCallback onItemSelected;

  const FitnessProgramDialogItem(
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
                // TODO make StyledText
                child: Text(
                  program.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: AppColors.WHITE,
                    fontStyle: FontStyle.normal,
                    fontFamily: 'rex',
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
