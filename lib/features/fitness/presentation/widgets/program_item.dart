import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:morningmagic/features/fitness/domain/entities/program/fitness_program.dart';

class ProgrammItem extends StatelessWidget {
  const ProgrammItem({Key key, @required this.program, this.callback}) : super(key: key);
  final FitnessProgram program;
  final VoidCallback callback;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            margin: const EdgeInsets.only(top: 12),
            alignment: Alignment.center,
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 30,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.3),
              borderRadius: BorderRadius.circular(19),
            ),
            child: Text(
              program.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xff592F72),
                fontSize: 15,
                fontWeight: FontWeight.w600,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
