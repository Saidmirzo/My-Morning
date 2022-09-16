import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/widgets/animatedButton.dart';

class DeleteProgressDialog extends Dialog {
   const DeleteProgressDialog(this.voidCallback, {Key key}) : super(key: key);

  final VoidCallback voidCallback;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: Center(
                child: Text(
                  'sure_delete_progress'.tr,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 23,
                      fontStyle: FontStyle.normal,
                      color: AppColors.VIOLET),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: Center(
                child: AnimatedButton(() {
                  voidCallback();
                  Navigator.pop(context, true);
                }, 'yes'.tr, 22, null, null),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 10),
              child: AnimatedButton(() {
                Navigator.pop(context, true);
              }, 'no'.tr, 22, null, null),
            ),
          ],
        ),
      ),
    );
  }
}
