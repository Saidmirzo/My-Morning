import 'package:hive/hive.dart';
import 'package:get/get.dart';

part 'affirmation_text_model.g.dart';

@HiveType(typeId: 156)
class AffirmationTextModel {
  @HiveField(0)
  final String _text;
  @HiveField(1)
  final bool isCustom;

  AffirmationTextModel(this._text, {this.isCustom = false});

  String get text => isCustom ? _text : _text.tr;
}
