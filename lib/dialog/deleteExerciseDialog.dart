import 'package:flutter/material.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/widgets/animatedButton.dart';
import 'package:get/get.dart';

class DeleteExerciseDialog extends Dialog {
  final VoidCallback voidCallback;

  const DeleteExerciseDialog(this.voidCallback, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 3.2,
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
                    'sure_delete'.tr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 23,
                        fontStyle: FontStyle.normal,
                        color: AppColors.violet),
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
      ),
    );
  }
}
