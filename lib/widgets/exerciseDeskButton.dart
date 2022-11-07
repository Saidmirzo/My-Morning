// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:morningmagic/db/model/app_and_custom_exercises/exercise_name.dart';
import 'package:morningmagic/dialog/deleteExerciseDialog.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/utils/progress_util.dart';

class ExerciseDeskButton extends StatelessWidget {
  final String id;
  final String text;
  final double size;
  final List<ExerciseName> list;
  final VoidCallback voidCallback;

  // ignore: use_key_in_widget_constructors
  const ExerciseDeskButton(
      {@required this.id,
      @required this.text,
      @required this.size,
      @required this.list,
      @required this.voidCallback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Draggable<ExerciseDeskTag>(
        data: ExerciseDeskTag(text, size),
        child: ExerciseDeskTag(text, size),
        childWhenDragging: Container(),
        feedback: ExerciseDeskTag(text, size),
      ),
      onLongPress: () async {
        await showDialog(
            context: context,
            builder: (BuildContext context) => DeleteExerciseDialog(() async {
                  for (int i = 0; i < list.length; i++) {
                    if (list[i].id == id) {
                      if (list[i].size == null) {
                        // if size null it means it's a custom exercise
                        await ExerciseUtils()
                            .deleteCustomExerciseFromDB(list[i]);
                      }

                      list.removeAt(i);
                      print("removed " + i.toString());
                      break;
                    }
                  }
                  voidCallback();
                }));
      },
    );
  }
}

class ExerciseDeskTag extends StatelessWidget {
  final String text;
  final double size;

  const ExerciseDeskTag(this.text, this.size);

  @override
  Widget build(BuildContext context) {
    return Container(
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
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              decoration: TextDecoration.none,
              color: AppColors.white,
              fontStyle: FontStyle.normal,
              fontSize: size ?? 14,
            ),
          ),
        ),
      ),
    );
  }
}
