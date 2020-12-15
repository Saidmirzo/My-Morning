import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:morningmagic/features/fitness/domain/entities/fitness_program.dart';
import 'package:morningmagic/features/fitness/presentation/controller/fitness_controller.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/app_gradient_container.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/dialogs/program_edit_dialog.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/styled_text.dart';
import 'package:morningmagic/resources/colors.dart';

class FitnessProgramSettingsPage extends StatefulWidget {
  @override
  _FitnessProgramSettingsPageState createState() =>
      _FitnessProgramSettingsPageState();
}

class _FitnessProgramSettingsPageState
    extends State<FitnessProgramSettingsPage> {
  final _fitnessController = Get.find<FitnessController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: _buildFloatingActionButtons(),
        body: AppGradientContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: _buildBackButton(context),
              ),
              Obx(
                () => Expanded(
                  child: _buildProgramList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListView _buildProgramList() {
    return ListView.builder(
      padding: EdgeInsets.only(bottom: 64),
      shrinkWrap: true,
      itemCount: _fitnessController.programs.length,
      itemBuilder: (context, index) => FitnessProgramEditItem(
        program: _fitnessController.programs[index],
      ),
    );
  }

  InkWell _buildBackButton(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0, left: 16.0, bottom: 8.0),
        child: StyledText(
          'Назад',
          fontSize: 24,
          color: Colors.white,
        ),
      ),
    );
  }

  Row _buildFloatingActionButtons() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 24,
        ),
        Expanded(
            child: FlatButton(
          color: Colors.white,
          onPressed: () => _fitnessController.restoreDefaultPrograms(),
          shape: new RoundedRectangleBorder(
              side: BorderSide(style: BorderStyle.solid, width: 1),
              borderRadius: new BorderRadius.circular(30.0)),
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 4),
            child: StyledText(
              'Восстановить\nпо умолчанию',
              fontSize: 16,
            ),
          ),
        )),
        SizedBox(width: 16),
        FloatingActionButton.extended(
          onPressed: () => showDialog(
            context: context,
            builder: (context) => ProgramEditDialog(),
          ),
          label: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: StyledText(
              'Создать\nсвою',
              color: Colors.white,
              fontSize: 16,
              textAlign: TextAlign.center,
            ),
          ),
          icon: Icon(Icons.add),
          backgroundColor: AppColors.PINK,
        ),
      ],
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
      child: Card(
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            print('Card tapped.');
          },
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 16, bottom: 8),
                  child: StyledText(
                    widget.program.name,
                    fontSize: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
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
                    Spacer(),
                    _buildProgramCardActionButton(
                        onPressed: () => showDeleteProgramDialog(context),
                        buttonColor: AppColors.PINK,
                        icon: Icons.delete,
                        title: 'Удалить'),
                    SizedBox(width: 8),
                    _buildProgramCardActionButton(
                        onPressed: () =>
                            _showEditProgramDialog(program: widget.program),
                        buttonColor: AppColors.VIOLET,
                        icon: Icons.edit,
                        title: 'Редактировать'),
                    SizedBox(width: 8)
                  ],
                ),
                SizedBox(
                  height: 4,
                )
              ],
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
                'Вы действительно хотите удалить программу?',
              ),
              actions: [
                FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Отмена'),
                ),
                FlatButton(
                  onPressed: () {
                    _fitnessController.deleteProgram(widget.program);
                    Navigator.pop(context);
                  },
                  child: Text('Удалить'),
                )
              ],
            ));
  }

  List<Widget> _buildExerciseChip(FitnessProgram program) {
    final widgets = List<Widget>();

    program.exercises.forEach((element) {
      widgets.add(
        Chip(
          backgroundColor: AppColors.VIOLET,
          label: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child:
                StyledText(element.name, color: AppColors.WHITE, fontSize: 12),
          ),
        ),
      );
    });

    return widgets;
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
