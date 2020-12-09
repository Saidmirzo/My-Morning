import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:morningmagic/features/fitness/presentation/controller/fitness_controller.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/app_gradient_container.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/fitness_menu_item_button.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/program_selection_dialog.dart';

import '../../../../pages/screenExerciseDesk.dart';
import '../../../../resources/colors.dart';

class FitnessMainPage extends StatelessWidget {
  final int pageId;
  final FitnessController controller = Get.put(FitnessController());

  FitnessMainPage({Key key, @required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppGradientContainer(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 48,
              ),
              Text(
                'fitness'.tr(),
                style: TextStyle(
                  fontSize: 32,
                  fontStyle: FontStyle.normal,
                  fontFamily: "rex",
                  color: AppColors.WHITE,
                ),
              ),
              SizedBox(
                height: 48,
              ),
              FitnessMenuItemButton(
                  onPressed: () => showProgramSelectionDialog(context),
                  text: 'fitness_program'.tr(), // начать программу
                  pageId: pageId),
              SizedBox(
                height: 16,
              ),
              FitnessMenuItemButton(
                  onPressed: () => navigateToCreateMyProgram(context),
                  text: 'fitness_my_program'.tr(), // создать программу
                  pageId: pageId),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showProgramSelectionDialog(BuildContext context) async {
    return await showDialog(context: context, child: ProgramSelectionDialog());
  }

  void navigateToCreateMyProgram(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ExerciseDeskScreen(pageId: pageId)));
  }
}
