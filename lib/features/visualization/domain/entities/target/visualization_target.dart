import 'package:enum_to_string/enum_to_string.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:morningmagic/features/visualization/domain/entities/image_tag.dart';
part 'visualization_target.g.dart';

@HiveType(typeId: 21)
class VisualizationTarget extends Equatable {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String tag;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final String coverAssetPath;

  bool get isCustom =>
      tag == EnumToString.convertToString(VisualizationImageTag.custom);

  const VisualizationTarget(
      {@required this.id,
      @required this.tag,
      @required this.title,
      this.coverAssetPath});

  @override
  List<Object> get props => [id, tag, title, coverAssetPath];
}
