
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'notepad.g.dart';

@HiveType(typeId: 150)
class Notepad {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String text;
  @HiveField(2)
  final String date;

  Notepad(
    this.id,
    this.text,
    this.date,
  );
}