import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'visualization_target.g.dart';

@HiveType(typeId: 21)
class VisualizationTarget extends Equatable {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final bool isCustom;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final String coverAssetPath;

  VisualizationTarget(
      {@required this.id,
      @required this.isCustom,
      @required this.title,
      this.coverAssetPath});

  @override
  List<Object> get props => [id, isCustom, title, coverAssetPath];
}
