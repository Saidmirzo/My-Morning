import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:morningmagic/features/fitness/domain/entities/exercise/fitness_exercise.dart';
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
                      text: 'back_button'.tr(),
                      onTap: () => Navigator.pop(context)),
                  Spacer(),
                  DialogHeaderButton(
                    text: 'save'.tr(),
                    onTap: () => saveExercise(context),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value.isEmpty) return 'name_not_be_empty'.tr();
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
                  hintText: 'type_exercise_name'.tr(),
                ),
                autofocus: true,
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _descriptionController,
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
                  hintText: 'type_exercise_description'.tr(),
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
          _nameTextController.text, _descriptionController.text ??= '',
          isCreatedByUser: true);
      Navigator.pop(context, _exercise);
    }
  }
}
