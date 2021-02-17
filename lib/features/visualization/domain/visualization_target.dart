import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'visualization_data_generator.dart';

class VisualizationTarget extends Equatable {
  final TargetType type;
  final String coverAssetPath;

  VisualizationTarget({@required this.type, this.coverAssetPath});

  @override
  List<Object> get props => [type, coverAssetPath];

  // TODO get from resources
  String get title  {
    switch (this.type) {
      case TargetType.success:
        return 'Успех';
        break;
      case TargetType.family:
        return 'Семья';
        break;
      case TargetType.nature:
        return 'Природа';
        break;
      case TargetType.sport:
        return 'Спорт';
        break;
      case TargetType.rest:
        return 'Отдых';
        break;
      case TargetType.custom:
        return 'моя цель!!';
        break;
      default:
        throw UnsupportedError('Unknown target type');
    }
  }
}
