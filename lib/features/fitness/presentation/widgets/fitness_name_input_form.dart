import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:morningmagic/resources/colors.dart';

class FitnessNameInputForm extends StatelessWidget {
  const FitnessNameInputForm({
    Key key,
    @required GlobalKey<FormState> formKey,
    @required TextEditingController textController,
    this.autoFocus = false,
  })  : _formKey = formKey,
        _textController = textController,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController _textController;
  final bool autoFocus;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: TextFormField(
        validator: (value) {
          if (value.isEmpty) return 'type_name'.tr;
          return null;
        },
        controller: _textController,
        decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.violet, width: 2),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.violet, width: 1),
          ),
          suffixIcon: IconButton(
            icon: const Icon(
              Icons.clear,
              color: AppColors.violet,
            ),
            onPressed: () => _textController.text = '',
          ),
          border: const OutlineInputBorder(),
          hintText: 'type_program_name'.tr,
        ),
        autofocus: autoFocus,
      ),
    );
  }
}
