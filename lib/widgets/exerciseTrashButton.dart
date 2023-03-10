import 'package:flutter/material.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/utils/progress_util.dart';

class ExerciseTrashTag extends StatefulWidget {
  const ExerciseTrashTag(this.text, this.size, this.myKey, this.callback);

  final String text;
  final double size;
  final String myKey;

  final VoidCallback callback;

  @override
  ExerciseTrashTagState createState() {
    return ExerciseTrashTagState();
  }
}

class ExerciseTrashTagState extends State<ExerciseTrashTag> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        ExerciseUtils()
            .deleteSelectedExerciseFromDB(widget.myKey)
            .then((value) {
          ExerciseUtils()
              .deleteSelectedExerciseProgramFromDB(widget.myKey)
              .then((value) {
            widget.callback();
          });
        });
      },
      child: Container(
        width: 130.0,
        height: 28.0,
        margin: const EdgeInsets.only(bottom: 10),
        decoration: const BoxDecoration(
            color: AppColors.pink,
            borderRadius: BorderRadius.all(Radius.circular(40))),
        child: Container(
          padding: const EdgeInsets.only(top: 2),
          child: Center(
            child: Text(
              widget.text,
              textAlign: TextAlign.center,
              style: TextStyle(
                decoration: TextDecoration.none,
                color: AppColors.white,
                fontStyle: FontStyle.normal,
                fontSize: widget.size,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
