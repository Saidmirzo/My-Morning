import 'package:flutter/material.dart';

class VisualizationBackButton extends StatelessWidget {
  final Color color;

  const VisualizationBackButton({Key key, this.color = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 36.0, left: 8),
      child: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            size: 36,
            color: color,
          ),
          onPressed: () => Navigator.pop(context)),
    );
  }
}
