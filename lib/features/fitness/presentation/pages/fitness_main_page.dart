import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:morningmagic/features/fitness/data/repositories/fitness_program_repository_impl.dart';
import 'package:morningmagic/features/fitness/presentation/controller/fitness_controller.dart';
import 'package:morningmagic/features/fitness/presentation/pages/fitness_program_settings.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/app_gradient_container.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/bg.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/dialogs/program_selection_dialog.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/styled_text.dart';
import 'package:morningmagic/routing/timer_page_ids.dart';
import 'package:morningmagic/utils/reordering_util.dart';
import 'package:morningmagic/widgets/primary_button.dart';
import 'package:morningmagic/widgets/primary_circle_button.dart';

import '../../../../resources/colors.dart';

class FitnessMainPage extends StatelessWidget {
  final int pageId;

  FitnessMainPage({Key key, @required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(FitnessController(repository: FitnessProgramRepositoryImpl()));
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: AppGradientContainer(
          child: Stack(
            children: [
              bg(),
              Container(
                width: Get.width,
                child: SafeArea(
                  bottom: false,
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: PrimaryCircleButton(
                          icon:
                              Icon(Icons.arrow_back, color: AppColors.primary),
                          onPressed: () {
                            OrderUtil()
                                .getPreviousRouteById(TimerPageId.Fitness)
                                .then((value) {
                              Get.off(value);
                            });
                          },
                        ),
                      ),
                      SizedBox(height: Get.height * 0.30),
                      StyledText('fitness'.tr,
                          fontWeight: FontWeight.w600,
                          color: AppColors.WHITE,
                          fontSize: Get.height * 0.024),
                      SizedBox(height: 48),
                      PrimaryButton(
                        onPressed: () => showProgramSelectionDialog(context),
                        text: 'start_program'.tr,
                        pWidth: 0.5,
                      ), // начать программу
                      SizedBox(height: 16),
                      PrimaryButton(
                        onPressed: () => navigateToProgramSettings(context),
                        text: 'program_settings'.tr,
                        pWidth: 0.5,
                      ), // создать программу),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showProgramSelectionDialog(BuildContext context) async {
    return await showDialog(
        context: context, builder: (context) => ProgramSelectionDialog());
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
