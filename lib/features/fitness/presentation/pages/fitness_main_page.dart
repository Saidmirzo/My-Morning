import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:morningmagic/features/fitness/presentation/controller/fitness_controller.dart';
import 'package:morningmagic/features/fitness/presentation/pages/fitness_program_settings.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/app_gradient_container.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/dialogs/program_selection_dialog.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/fitness_main_menu_button.dart';

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
              FitnessMainMenuButton(
                  onPressed: () => showProgramSelectionDialog(context),
                  text: 'Начать программу', // начать программу
                  pageId: pageId),
              SizedBox(
                height: 16,
              ),
              FitnessMainMenuButton(
                  onPressed: () => navigateToProgramSettings(context),
                  text: 'Настройки программ', // создать программу
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

  void navigateToProgramSettings(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => FitnessProgramSettingsPage()));
  }
}
