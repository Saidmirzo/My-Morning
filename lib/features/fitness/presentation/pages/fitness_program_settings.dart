import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:morningmagic/features/fitness/domain/entities/program/fitness_program.dart';
import 'package:morningmagic/features/fitness/presentation/controller/fitness_controller.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/dialogs/program_edit_dialog.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/styled_text.dart';
import 'package:morningmagic/resources/colors.dart';
import 'fitness_main_page.dart';

class FitnessProgramSettingsPage extends StatefulWidget {
  const FitnessProgramSettingsPage({Key key}) : super(key: key);

  @override
  _FitnessProgramSettingsPageState createState() =>
      _FitnessProgramSettingsPageState();
}

class _FitnessProgramSettingsPageState
    extends State<FitnessProgramSettingsPage> {
  final _fitnessController = Get.find<FitnessController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: _buildFloatingActionButtons(),
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/fitnes/settings_bg.png'),
                fit: BoxFit.fill)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 31,
                vertical: 38,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FitnessMainPage(
                                  fromHomeMenu: true,
                                ))),
                    child: const Icon(
                      Icons.west,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Fitnes'.tr,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Montserrat'),
                  ),
                  const SizedBox(
                    width: 20,
                  )
                ],
              ),
            ),

            // Align(
            //   alignment: Alignment.centerLeft,
            //   child: _buildBackButton(context),
            // ),
            Obx(
              () => Expanded(
                child: _buildProgramList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListView _buildProgramList() {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 64),
      shrinkWrap: true,
      itemCount: _fitnessController.programs.length,
      itemBuilder: (context, index) => FitnessProgramEditItem(
        program: _fitnessController.programs[index],
      ),
    );
  }

  // InkWell _buildBackButton(BuildContext context) {
  //   return InkWell(
  //     onTap: () => Navigator.pop(context),
  //     child: Padding(
  //       padding: const EdgeInsets.only(top: 16.0, left: 16.0, bottom: 8.0),
  //       child: StyledText(
  //         'back_button'.tr,
  //         fontSize: 24,
  //         color: Colors.white,
  //       ),
  //     ),
  //   );
  // }

  // Row _buildFloatingActionButtons() {
  //   return Row(
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     children: [
  //       const SizedBox(
  //         width: 24,
  //       ),
  //       Expanded(
  //           child: FlatButton(
  //         color: Colors.white,
  //         onPressed: () => restoreDefault(context),
  //         shape: RoundedRectangleBorder(
  //             side: const BorderSide(style: BorderStyle.solid, width: 1),
  //             borderRadius: BorderRadius.circular(30.0)),
  //         child: Padding(
  //           padding: const EdgeInsets.only(top: 8.0, bottom: 4),
  //           child: StyledText(
  //             'restore_default'.tr,
  //             fontSize: 16,
  //             textAlign: TextAlign.center,
  //           ),
  //         ),
  //       )),
  //       const SizedBox(width: 16),
  //       FloatingActionButton.extended(
  //         onPressed: () => showDialog(
  //           context: context,
  //           builder: (context) => const ProgramEditDialog(),
  //         ),
  //         label: Padding(
  //           padding: const EdgeInsets.only(top: 4.0),
  //           child: StyledText(
  //             'create_yours'.tr,
  //             color: Colors.white,
  //             fontSize: 16,
  //             textAlign: TextAlign.center,
  //           ),
  //         ),
  //         icon: const Icon(Icons.add),
  //         backgroundColor: AppColors.PINK,
  //       ),
  //     ],
  //   );
  // }

  void restoreDefault(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'restore_default_dialog_title'.tr,
        ),
        actions: [
          FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Text('cancellation'.tr),
          ),
          FlatButton(
            onPressed: () {
              _fitnessController.restoreDefaultPrograms();
              Navigator.pop(context);
            },
            child: Text('restore'.tr),
          )
        ],
      ),
    );
  }
}

class FitnessProgramEditItem extends StatefulWidget {
  final FitnessProgram program;

  const FitnessProgramEditItem({Key key, this.program}) : super(key: key);

  @override
  _FitnessProgramEditItemState createState() => _FitnessProgramEditItemState();
}

class _FitnessProgramEditItemState extends State<FitnessProgramEditItem> {
  bool isExpanded = false;
  final _fitnessController = Get.find<FitnessController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          print('Card tapped.');
        },
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 31),
              padding: const EdgeInsets.fromLTRB(17.51, 24.42, 17.51, 18.16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(19),
                color: Colors.white.withOpacity(.56),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StyledText(
                    widget.program.name,
                    fontSize: 14,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 17, bottom: 9.3),
                    child: Obx(() {
                      final _program =
                          _fitnessController.findProgram(widget.program);

                      return Wrap(
                        spacing: 4,
                        children: _buildExerciseChip(_program),
                      );
                    }),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () =>
                              _showEditProgramDialog(program: widget.program),
                          child: Container(
                            height: 56.14,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.87),
                              color: const Color(0xff592F72),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Edit'.tr,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12.43,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 7.41,
                      ),
                      GestureDetector(
                        onTap: () => showDeleteProgramDialog(context),
                        child: Container(
                          width: 56.14,
                          height: 56.14,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.87),
                            color: const Color(0xffFF0000).withOpacity(0.08),
                          ),
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/images/fitnes/delete_icon.png',
                            width: 18.85,
                            height: 24.32,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Row(
                  //   children: [
                  //     const Spacer(),
                  //     _buildProgramCardActionButton(
                  //         onPressed: () =>
                  //             _showEditProgramDialog(program: widget.program),
                  //         buttonColor: AppColors.VIOLET,
                  //         icon: Icons.edit,
                  //         title: 'edit'.tr),
                  //     const SizedBox(width: 8),
                  //     _buildProgramCardActionButton(
                  //         onPressed: () => showDeleteProgramDialog(context),
                  //         buttonColor: AppColors.PINK,
                  //         icon: Icons.delete,
                  //         title: 'delete'.tr),

                  //     const SizedBox(width: 8)
                  //   ],
                  // ),
                  const SizedBox(
                    height: 4,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  FlatButton _buildProgramCardActionButton(
      {@required VoidCallback onPressed,
      @required Color buttonColor,
      @required String title,
      @required IconData icon}) {
    return FlatButton.icon(
      color: buttonColor,
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: AppColors.WHITE,
      ),
      label: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: StyledText(
          title,
          fontSize: 16,
          color: AppColors.WHITE,
        ),
      ),
    );
  }

  Future showDeleteProgramDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                'delete_program_alert'.tr,
              ),
              actions: [
                FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('cancellation'.tr),
                ),
                FlatButton(
                  onPressed: () {
                    _fitnessController.deleteProgram(widget.program);
                    Navigator.pop(context);
                  },
                  child: Text('delete'.tr),
                )
              ],
            ));
  }

  List<Widget> _buildExerciseChip(FitnessProgram program) {
    return List.generate(
      program.exercises.length,
      (i) => Container(
        margin: const EdgeInsets.only(bottom: 4.7),
        padding: const EdgeInsets.symmetric(
          horizontal: 18.5,
          vertical: 10.5,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.87),
          color: Colors.white.withOpacity(.84),
        ),
        child: Text(
          program.exercises[i].name,
          style: const TextStyle(
            color: Color(0xff592F72),
            fontSize: 12,
            fontWeight: FontWeight.w500,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
    );
  }

  Future<void> _showEditProgramDialog({FitnessProgram program}) async {
    await showDialog(
      context: context,
      builder: (context) => ProgramEditDialog(
        program: program,
      ),
    );
  }
}
