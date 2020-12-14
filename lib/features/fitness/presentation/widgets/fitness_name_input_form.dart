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
        autofocus: autoFocus,
      ),
    );
  }
}
