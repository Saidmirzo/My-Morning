import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/dialog/back_to_main_menu_dialog.dart';
import 'package:morningmagic/features/fitness/data/repositories/fitness_program_repository_impl.dart';
import 'package:morningmagic/features/fitness/presentation/controller/fitness_controller.dart';
import 'package:morningmagic/features/fitness/presentation/pages/exercise_page.dart';
import 'package:morningmagic/features/fitness/presentation/pages/fitness_program_settings.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/app_gradient_container.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/dialogs/program_selection_dialog.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/program_item.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/styled_text.dart';
import 'package:morningmagic/pages/menu/main_menu.dart';
import 'package:morningmagic/routing/route_values.dart';
import 'package:morningmagic/services/analitics/all.dart';
import '../../../../resources/colors.dart';

class FitnessMainPage extends StatefulWidget {
  final int pageId;
  final bool fromHomeMenu;

  const FitnessMainPage(
      {Key key, @required this.pageId, this.fromHomeMenu = false})
      : super(key: key);

  @override
  State<FitnessMainPage> createState() => _FitnessMainPageState();
}

class _FitnessMainPageState extends State<FitnessMainPage> {
  @override
  void initState() {
    Get.lazyPut(() => FitnessController(
          repository: FitnessProgramRepositoryImpl(),
          fromHomeMenu: widget.fromHomeMenu,
        ));
    Future.delayed(Duration.zero, () => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final fitnessController = Get.find<FitnessController>();
    final programs = fitnessController.programs
        .where((program) => program.exercises.isNotEmpty)
        .toList();
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: AppGradientContainer(
          child: Stack(
            children: [
              //bg(),
              SizedBox(
                width: double.maxFinite,
                height: double.maxFinite,
                child: Image.asset('assets/images/fitnes/fitmain.jpeg',
                    fit: BoxFit.fill),
              ),
              SizedBox(
                width: Get.width,
                child: SafeArea(
                  bottom: false,
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 34,
                      ),
                      // Align(
                      //   alignment: Alignment.topLeft,
                      //   child: PrimaryCircleButton(
                      //     icon:
                      //         const Icon(Icons.arrow_back, color: AppColors.primary),
                      //     onPressed: () {
                      // Get.delete<FitnessController>();
                      // if (fromHomeMenu) {
                      //   return Get.off(MainMenuPage(), opaque: true);
                      // }
                      // OrderUtil()
                      //     .getPreviousRouteById(TimerPageId.Fitness)
                      //     .then((value) {
                      //   Get.off(value);
                      // });
                      //     },
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 31),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (isComplex) {
                                  showDialog(
                                    context: context,
                                    builder: (context) =>
                                        const BackToMainMenuDialog(),
                                  );
                                } else {
                                  Get.delete<FitnessController>();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const MainMenuPage()),
                                  );
                                }
                              },
                              child: const Icon(
                                Icons.west,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () => navigateToProgramSettings(context),
                              child: SizedBox(
                                width: 21,
                                height: 21,
                                child: Image.asset(
                                  'assets/images/home_menu/settings_icon_1.png',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 98),
                      StyledText(
                        'fitness'.tr,
                        fontWeight: FontWeight.w600,
                        color: AppColors.white,
                        fontSize: 24,
                      ),
                      const SizedBox(height: 53),
                      // PrimaryButton(
                      //   onPressed: () => showProgramSelectionDialog(context),
                      //   text: 'start_program'.tr,
                      //   pWidth: 0.5,
                      // ), // начать программу
                      // // const SizedBox(height: 16),
                      // // PrimaryButton(
                      // //   onPressed: () => navigateToProgramSettings(context),
                      // //   text: 'program_settings'.tr,
                      // //   pWidth: 0.5,
                      // // ), // создать программу),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 31,
                          ),
                          child: ListView.builder(
                            itemCount: programs.length,
                            itemBuilder: (context, i) {
                              return ProgrammItem(
                                program: programs[i],
                                callback: () {
                                  fitnessController.selectedProgram =
                                      programs[i];
                                  fitnessController.step = 0;
                                  final _exercise =
                                      fitnessController.currentExercise;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ExercisePage(
                                        fitnessController.selectedProgram.name,
                                        _exercise,
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              if (isComplex)
                Positioned(
                  top: 40,
                  right: 30,
                  child: GestureDetector(
                    onTap: () {
                      appAnalitics.logEvent('first_menu_setings');
                      Navigator.pushNamed(context, settingsPageRoute);
                    },
                    child: Container(
                      width: 47.05,
                      height: 47.05,
                      padding: const EdgeInsets.all(12.76),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: Image.asset(
                        'assets/images/home_menu/settings_icon_2.png',
                      ),
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
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const FitnessProgramSettingsPage()));
  }

  Future<bool> _onWillPop() async {
    Get.delete<FitnessController>();
    return true;
  }
}
