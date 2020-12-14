import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:morningmagic/features/fitness/models/fitness_exercise.dart';
import 'package:morningmagic/features/fitness/models/fitness_program.dart';
import 'package:morningmagic/features/fitness/presentation/controller/fitness_controller.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/dialog_action_button.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/exercise_edit_dialog_item.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/styled_text.dart';
import 'package:morningmagic/resources/colors.dart';

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
              Text(
                'Удерживайте упражнение, чтобы перетащить в нужное место',
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

  FlatButton _buildAddNewExerciseButton() {
    return FlatButton.icon(
        onPressed: () => {},
        shape: new RoundedRectangleBorder(
            side: BorderSide(style: BorderStyle.solid, width: 1),
            borderRadius: new BorderRadius.circular(30.0)),
        icon: Icon(
          Icons.add,
          color: AppColors.VIOLET,
        ),
        label: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: StyledText(
            'Добавить упражнение',
            fontSize: 16,
          ),
        ));
  }

  Form _buildProgramNameInputForm() {
    return Form(
      key: _formKey,
      child: TextFormField(
        validator: (value) {
          if (value.isEmpty) return 'Введите название';
          return null;
        },
        controller: _textController,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.VIOLET, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.VIOLET, width: 1),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              Icons.clear,
              color: AppColors.VIOLET,
            ),
            onPressed: () => _textController.text = '',
          ),
          border: OutlineInputBorder(),
          hintText: 'Введите название программы',
        ),
        autofocus: false,
      ),
    );
  }

  Row _buildDialogHeader(BuildContext context) {
    return Row(
      children: [
        DialogActionButton(
          text: 'назад',
          onTap: () => Navigator.pop(context),
        ),
        Spacer(),
        DialogActionButton(
          text: 'сохранить',
          onTap: () => _saveProgram(context),
        ),
      ],
    );
  }

  List<Widget> _buildExerciseItems(BuildContext context,
      List<FitnessExercise> exercises, ExerciseCallback onDelete) {
    final List<Widget> widgets = [];
    exercises.forEach((element) {
      widgets.add(ExerciseItem(
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
      final _newProgram = FitnessProgram(
          name: _textController.text,
          isCreatedByUser: _isCreatedByUser,
          exercises: exercises);
      (widget.program != null)
          ? _fitnessController.updateProgram(widget.program, _newProgram)
          : _fitnessController.addProgram(_newProgram);

      Navigator.pop(context);
    }
  }
}
