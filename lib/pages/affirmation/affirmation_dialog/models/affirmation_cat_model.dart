import 'package:hive/hive.dart';
import 'package:morningmagic/pages/affirmation/affirmation_dialog/models/affirmation_text_model.dart';
import 'package:get/get.dart';

part 'affirmation_cat_model.g.dart';

@HiveType(typeId: 154)
class AffirmationCategoryModel {
  @HiveField(0)
  final String _name;
  @HiveField(1)
  final bool isCustom;
  @HiveField(2)
  final List<AffirmationTextModel> affirmations;

  AffirmationCategoryModel(this._name,
      {this.isCustom = false, this.affirmations});

  String get name => isCustom ? _name : _name.tr;
}
