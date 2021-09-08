import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/services/localization/localization_service.dart';

void showLangDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return _landDialog();
      }).then((value) => LocalizationService.switchLocale(value));
}

AlertDialog _landDialog() {
  return AlertDialog(
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
          child: Text(
            'language'.tr,
            style: _textStyle(weight: FontWeight.bold, fontSize: .055),
          ),
        ),
        _btnDialog(
            title: 'English',
            onPress: () => Get.back(result: LocalizationService.EN)),
        _btnDialog(
            title: 'Русский',
            onPress: () => Get.back(result: LocalizationService.RU)),
      ],
    ),
  );
}

Widget _btnDialog({String title, Function() onPress}) {
  return TextButton(
      onPressed: onPress,
      child: Text(
        title,
        style: _textStyle(),
      ));
}

TextStyle _textStyle(
    {FontWeight weight = FontWeight.normal, double fontSize = .045}) {
  return TextStyle(
    fontSize: Get.width * fontSize,
    fontWeight: weight,
    color: AppColors.primary,
  );
}
