import 'package:flutter/material.dart';
import 'package:morningmagic/packages/day_night_picker/create_day_night_picker.dart';


class AddTimeDialog extends StatefulWidget {
  final TimeOfDay initTime;

  const AddTimeDialog({Key key, this.initTime}) : super(key: key);

  @override
  State<AddTimeDialog> createState() => _AddTimeDialogState();
}

class _AddTimeDialogState extends State<AddTimeDialog> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: createDayNightPicker(),
    );
  }
}
