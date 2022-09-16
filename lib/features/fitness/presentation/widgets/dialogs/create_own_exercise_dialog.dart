import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:morningmagic/features/fitness/domain/entities/exercise/fitness_exercise.dart';
import 'package:morningmagic/resources/colors.dart';
import '../dialog_header_button.dart';

class CreateOwnExerciseDialog extends StatefulWidget {
  const CreateOwnExerciseDialog({Key key}) : super(key: key);

  @override
  _CreateOwnExerciseDialogState createState() =>
      _CreateOwnExerciseDialogState();
}

class _CreateOwnExerciseDialogState extends State<CreateOwnExerciseDialog> {
  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Row(
                  children: [
                    DialogHeaderButton(
                        text: 'back_button'.tr,
                        onTap: () => Navigator.pop(context)),
                    const Spacer(),
                    DialogHeaderButton(
                      text: 'save'.tr,
                      onTap: () => saveExercise(context),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value.isEmpty) return 'name_not_be_empty'.tr;
                    return null;
                  },
                  controller: _nameTextController,
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.VIOLET, width: 2),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.VIOLET, width: 1),
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.clear,
                        color: AppColors.VIOLET,
                      ),
                      onPressed: () => _nameTextController.text = '',
                    ),
                    border: const OutlineInputBorder(),
                    hintText: 'type_exercise_name'.tr,
                  ),
                  autofocus: true,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.VIOLET, width: 2),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.VIOLET, width: 1),
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.clear,
                        color: AppColors.VIOLET,
                      ),
                      onPressed: () => _descriptionController.text = '',
                    ),
                    border: const OutlineInputBorder(),
                    hintText: 'type_exercise_description'.tr,
                  ),
                  minLines: 10,
                  maxLines: 10,
                )
              ],
            ),
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
