import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:morningmagic/features/fitness/models/fitness_exercise.dart';

import '../dialog_header_button.dart';
import '../fitness_name_input_form.dart';

class CreateOwnExerciseDialog extends StatefulWidget {
  @override
  _CreateOwnExerciseDialogState createState() =>
      _CreateOwnExerciseDialogState();
}

class _CreateOwnExerciseDialogState extends State<CreateOwnExerciseDialog> {
  TextEditingController _textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      title: FitnessNameInputForm(
        formKey: _formKey,
        textController: _textController,
        autoFocus: true,
      ),
      actions: [
        DialogHeaderButton(text: 'назад', onTap: () => Navigator.pop(context)),
        DialogHeaderButton(
          text: 'сохранить',
          onTap: () {
            if (_formKey.currentState.validate()) {
              final _exercise =
                  FitnessExercise(name: _textController.text, description: '');
              Navigator.pop(context, _exercise);
            }
          },
        ),
      ],
    );
  }
}
