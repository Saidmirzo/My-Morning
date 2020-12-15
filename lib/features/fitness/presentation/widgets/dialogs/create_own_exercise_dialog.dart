import 'package:flutter/material.dart';
import 'package:morningmagic/features/fitness/domain/entities/fitness_exercise.dart';
import 'package:morningmagic/resources/colors.dart';

import '../dialog_header_button.dart';

class CreateOwnExerciseDialog extends StatefulWidget {
  @override
  _CreateOwnExerciseDialogState createState() =>
      _CreateOwnExerciseDialogState();
}

// TODO make focus
class _CreateOwnExerciseDialogState extends State<CreateOwnExerciseDialog> {
  TextEditingController _nameTextController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                children: [
                  DialogHeaderButton(
                      text: 'назад', onTap: () => Navigator.pop(context)),
                  Spacer(),
                  DialogHeaderButton(
                    text: 'сохранить',
                    onTap: () => saveExercise(context),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              // TODO form 1
              TextFormField(
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value.isEmpty) return 'Название не может быть пустым';
                  return null;
                },
                controller: _nameTextController,
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
                    onPressed: () => _nameTextController.text = '',
                  ),
                  border: OutlineInputBorder(),
                  hintText: 'Введите название упражнения',
                ),
                autofocus: true,
              ),
              SizedBox(
                height: 16,
              ),
              // TODo Form 2
              TextFormField(
                // validator: (value) {
                //   if (value.isEmpty) return 'Шаг упражнения';
                //   return null;
                // },
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
                    onPressed: () => _descriptionController.text = '',
                  ),
                  border: OutlineInputBorder(),
                  hintText: 'Введите описание упражнения',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void saveExercise(BuildContext context) {
    if (_formKey.currentState.validate()) {
      final _exercise = FitnessExercise(
          name: _nameTextController.text,
          description: _descriptionController.text ??= '');
      Navigator.pop(context, _exercise);
    }
  }
}
