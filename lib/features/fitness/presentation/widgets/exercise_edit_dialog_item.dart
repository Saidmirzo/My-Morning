import 'package:flutter/material.dart';
import 'package:morningmagic/features/fitness/domain/entities/fitness_exercise.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/styled_text.dart';
import 'package:morningmagic/resources/colors.dart';

class ExerciseEditDialogItem extends StatelessWidget {
  final FitnessExercise exercise;
  final VoidCallback onDeleteItem;

  ExerciseEditDialogItem(
      {Key key, @required this.exercise, @required this.onDeleteItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      decoration: BoxDecoration(
          color: AppColors.LIGHT_VIOLET,
          borderRadius: BorderRadius.all(Radius.circular(40))),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 8.0, top: 12, bottom: 8),
              child: StyledText(
                exercise.name,
                color: AppColors.WHITE,
                fontSize: 18,
                textAlign: TextAlign.start,
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.delete,
              color: AppColors.WHITE,
            ),
            onPressed: onDeleteItem,
          ),
        ],
      ),
    );
  }
}
