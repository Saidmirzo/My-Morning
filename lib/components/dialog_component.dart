import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:morningmagic/utils/app_keys.dart';

class DialogComponent {
  void loading() {
    showDialog(
      barrierDismissible: false,
      context: AppKeys.navigatorKey.currentContext,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Center(
            child: CircularProgressIndicator(color: Colors.white),
          ),
        );
      },
    );
  }
}
