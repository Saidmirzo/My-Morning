import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/resources/colors.dart';
import 'affirmation_controller.dart';

class AddCategoryAffirmation extends StatelessWidget {
  final TextEditingController _textController = TextEditingController();
  final AffirmationController _controller = Get.find();

  AddCategoryAffirmation({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 1.3,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildMenu(),
              const SizedBox(height: 8),
              buildTextFormField(),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField buildTextFormField() {
    return TextFormField(
      textInputAction: TextInputAction.next,
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
          onPressed: () => _textController.clear(),
        ),
        border: const OutlineInputBorder(),
        hintText: 'input_cat_name'.tr,
      ),
      autofocus: true,
    );
  }

  Row buildMenu() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
          child: InkWell(
            onTap: () => Get.back(),
            child: Text(
              'back_button'.tr,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 23,
                  fontStyle: FontStyle.normal,
                  color: AppColors.violet),
            ),
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
          child: InkWell(
            onTap: () async {
              if (_textController.text.isNotEmpty) {
                _controller.addAffirmationCategory(_textController.text);
              }
              Get.back();
            },
            child: Text(
              'choose'.tr,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 23,
                  fontStyle: FontStyle.normal,
                  color: AppColors.violet),
            ),
          ),
        )
      ],
    );
  }
}
