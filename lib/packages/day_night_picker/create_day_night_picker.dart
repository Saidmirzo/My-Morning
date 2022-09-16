
import 'package:flutter/material.dart';
import 'package:morningmagic/packages/day_night_picker/picker/picker.dart';
import 'package:morningmagic/packages/day_night_picker/providers/day_night_picker_provider.dart';
import 'package:provider/provider.dart';

Widget createDayNightPicker() {
  return ChangeNotifierProvider(
    create: (context) => PickerProvider(),
    child: DayNightTimePicker(),
  );
}