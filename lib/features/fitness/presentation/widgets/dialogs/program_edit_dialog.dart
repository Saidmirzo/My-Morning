import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:morningmagic/features/fitness/domain/entities/exercise/fitness_exercise.dart';
import 'package:morningmagic/features/fitness/domain/entities/program/fitness_program.dart';
import 'package:morningmagic/features/fitness/presentation/controller/fitness_controller.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/dialog_footer_button.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/dialog_header_button.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/dialogs/add_exercise_dialog.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/exercise_edit_dialog_item.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/fitness_name_input_form.dart';

typedef ExerciseCallback = void Function(FitnessExercise exercise);

class ProgramEditDialog extends StatefulWidget {
  final FitnessProgram program;

  const ProgramEditDialog({Key key, this.program}) : super(key: key);

  @override
  _ProgramEditDialogState createState() => _ProgramEditDialogState();
}

class _ProgramEditDialogState extends State<ProgramEditDialog> {
  TextEditingController _textController;
  FitnessController _fitnessController;
  final _formKey = GlobalKey<FormState>();

  List<FitnessExercise> exercises;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _fitnessController = Get.find();

    if (widget.program == null) {
      _textController.text = '';
      exercises = [];
    } else {
      _textController.text = widget.program.name;
      exercises = [...widget.program.exercises];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 8,
              ),
              _buildDialogHeader(context),
              SizedBox(
                height: 8,
              ),
              _buildProgramNameInputForm(),
              SizedBox(
                height: 8,
              ),
              if (exercises.isNotEmpty)
                Text(
                  'hold_to_move_exercise'.tr(),
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              SizedBox(
                height: 8,
              ),
              Expanded(
                child: ReorderableListView(
                  children: _buildExerciseItems(context, exercises, (exercise) {
                    setState(() {
                      exercises.remove(exercise);
                    });
                  }),
                  onReorder: (oldIndex, newIndex) {
                    setState(() {
                      final _exercises = exercises;
                      if (newIndex > oldIndex) {
                        newIndex -= 1;
                      }
                      final _exercise = _exercises.removeAt(oldIndex);
                      _exercises.insert(newIndex, _exercise);
                    });
                  },
                ),
              ),
              _buildAddNewExerciseButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddNewExerciseButton() => DialogFooterButton(
      text: 'add_exercises'.tr(),
      onPressed: () => _openAddExerciseDialog(context, exercises));

  Widget _buildProgramNameInputForm() =>
      FitnessNameInputForm(formKey: _formKey, textController: _textController);

  Row _buildDialogHeader(BuildContext context) {
    return Row(
      children: [
        DialogHeaderButton(
          text: 'back_button'.tr(),
          onTap: () => Navigator.pop(context),
        ),
        Spacer(),
        DialogHeaderButton(
          text: 'save'.tr(),
          onTap: () => _saveProgram(context),
        ),
      ],
    );
  }

  List<Widget> _buildExerciseItems(BuildContext context,
      List<FitnessExercise> exercises, ExerciseCallback onDelete) {
    final List<Widget> widgets = [];
    exercises.forEach((element) {
      widgets.add(ExerciseEditDialogItem(
        exercise: element,
        onDeleteItem: () {
          onDelete(element);
        },
        key: ValueKey(element),
      ));
    });

    return widgets;
  }

  void _saveProgram(BuildContext context) {
    if (_formKey.currentState.validate()) {
      bool _isCreatedByUser =
          (widget.program != null) ? widget.program.isCreatedByUser : true;
      final _newProgram = FitnessProgram(_textController.text,
          isCreatedByUser: _isCreatedByUser, exercises: exercises);
      (widget.program != null)
          ? _fitnessController.updateProgram(widget.program, _newProgram)
          : _fitnessController.addProgram(_newProgram);

      Navigator.pop(context);
    }
  }

  Future<void> _openAddExerciseDialog(
      BuildContext context, List<FitnessExercise> initialExercises) async {
    final List<FitnessExercise> _result = await showDialog(
      context: context,
      builder: (context) => AddExerciseDialog(
        initialExercises: initialExercises,
      ),
    );
    if (_result != null) {
      setState(() {
        exercises.addAll(_result);
      });
    }
  }
}
