import 'package:flutter/material.dart';
import 'package:morningmagic/resources/colors.dart';

import 'package:get/get.dart';
import 'exerciseTrashButton.dart';

class ExerciseTrashTarget extends StatefulWidget {
  const ExerciseTrashTarget(this.callback);

  final VoidCallback callback;

  @override
  ExerciseTrashTargetState createState() {
    return ExerciseTrashTargetState();
  }
}

class ExerciseTrashTargetState extends State<ExerciseTrashTarget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget<ExerciseTrashTag>(
      builder: (BuildContext context, List<ExerciseTrashTag> candidateData,
          List<dynamic> rejectedData) {
        return Container(
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.width * 0.4,
          decoration: BoxDecoration(
              color: candidateData.isEmpty
                  ? AppColors.transparent
                  : AppColors.transparentWhite),
          child: Center(
            child: Text('delete_exercise'.tr,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 23,
                    fontStyle: FontStyle.normal,
                    color: AppColors.transparentViolet)),
          ),
        );
      },
      onAccept: (ExerciseTrashTag tag) {
        widget.callback();
      },
    );
  }
}
