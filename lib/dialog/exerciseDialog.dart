import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/db/model/app_and_custom_exercises/exercise_name.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/utils/progress_util.dart';
import 'package:morningmagic/widgets/animatedButton.dart';
import 'package:random_string/random_string.dart';

class ExerciseDialog extends Dialog {
  final TextEditingController _controller;
  final VoidCallback _backCallback;
  final VoidCallback _addCallback;
  final List<ExerciseName> list;

  const ExerciseDialog(
      this._controller, this._backCallback, this._addCallback, this.list,
      {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 2.9,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 10),
                child: Center(
                  child: Text(
                    'enter_your_exercise'.tr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 23,
                        fontStyle: FontStyle.normal,
                        color: AppColors.violet),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 10, top: 10),
                child: TextField(
                  controller: _controller,
                  minLines: 1,
                  maxLines: 1,
                  cursorColor: AppColors.lightGray,
                  keyboardType: TextInputType.text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 23,
                      fontStyle: FontStyle.normal,
                      color: AppColors.violet,
                      decoration: TextDecoration.none),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'your_exercise'.tr,
                      hintStyle: const TextStyle(
                        color: AppColors.lightGray,
                      )),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  AnimatedButton(() {
                    if (_controller.text.isNotEmpty) {
                      ExerciseName exerciseName =
                          ExerciseName(randomAlpha(10), _controller.text, null);
                      list.add(exerciseName);
                      ExerciseUtils()
                          .saveCustomExerciseToDB(exerciseName)
                          .then((value) {
                        _addCallback();
                        _backCallback();
                      });
                    }
                  }, 'add_exercise'.tr, 18, null, null),
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    child: AnimatedButton(
                        _backCallback, 'back_button'.tr, 18, null, null),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
