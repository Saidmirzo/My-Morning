import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/resources/colors.dart';

class AddTextReminder extends StatelessWidget {
  TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            buildMenu(),
            buildTextFormField(),
          ],
        ),
      ),
    );
  }

  Widget buildTextFormField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25),
      child: TextFormField(
        textInputAction: TextInputAction.next,
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
            onPressed: () => _textController.clear(),
          ),
          border: OutlineInputBorder(),
          hintText: 'input_desc'.tr,
        ),
        autofocus: true,
      ),
    );
  }

  Row buildMenu() {
    return Row(
      children: [
        Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
          child: InkWell(
            onTap: () async {
              Get.back(
                  result: _textController.text.isEmpty
                      ? null
                      : _textController.text);
            },
            child: Text(
              'done'.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 23,
                  fontStyle: FontStyle.normal,
                  color: AppColors.VIOLET),
            ),
          ),
        )
      ],
    );
  }
}
