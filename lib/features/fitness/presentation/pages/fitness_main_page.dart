import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:morningmagic/features/fitness/data/repositories/fitness_program_repository_impl.dart';
import 'package:morningmagic/features/fitness/presentation/controller/fitness_controller.dart';
import 'package:morningmagic/features/fitness/presentation/pages/fitness_program_settings.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/app_gradient_container.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/dialogs/program_selection_dialog.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/fitness_main_menu_button.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/styled_text.dart';

import '../../../../resources/colors.dart';

class FitnessMainPage extends StatelessWidget {
  final int pageId;
  final FitnessController controller =
      Get.put(FitnessController(repository: FitnessProgramRepositoryImpl()));

  FitnessMainPage({Key key, @required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: AppGradientContainer(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 48,
                ),
                StyledText(
                  'fitness'.tr,
                  color: AppColors.WHITE,
                  fontSize: 32,
                ),
                SizedBox(
                  height: 48,
                ),
                FitnessMainMenuButton(
                    onPressed: () => showProgramSelectionDialog(context),
                    text: 'start_program'.tr, // начать программу
                    pageId: pageId),
                SizedBox(
                  height: 16,
                ),
                FitnessMainMenuButton(
                    onPressed: () => navigateToProgramSettings(context),
                    text: 'program_settings'.tr, // создать программу
                    pageId: pageId),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> showProgramSelectionDialog(BuildContext context) async {
    return await showDialog(context: context, builder: (context) => ProgramSelectionDialog());
  }

  void navigateToProgramSettings(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => FitnessProgramSettingsPage()));
  }

  Future<bool> _onWillPop() async {
    Get.delete<FitnessController>();
    return true;
  }
}
