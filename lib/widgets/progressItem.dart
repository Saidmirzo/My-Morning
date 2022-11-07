import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:morningmagic/resources/colors.dart';

class ProgressPair extends StatelessWidget {
  final String exerciseTitle;
  final String exerciseValue;

  const ProgressPair(this.exerciseTitle, this.exerciseValue);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            child: Text(
              exerciseTitle,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.violet,
                fontStyle: FontStyle.normal,
              ),
            ),
          ),
          Container(
            child: const Text(' – '),
          ),
          Flexible(
            child: Container(
              child: Text(
                exerciseValue,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.violet,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
