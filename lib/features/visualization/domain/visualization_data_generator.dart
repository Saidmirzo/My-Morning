import 'package:morningmagic/features/visualization/domain/visualization_target.dart';

class VisualizationDataGenerator {
  static List<VisualizationTarget> generateTargets() {
    return [
      VisualizationTarget(
          type: TargetType.success,
          coverAssetPath: 'assets/images/targets/success.png'),
      VisualizationTarget(
          type: TargetType.family,
          coverAssetPath: 'assets/images/targets/family.png'),
      VisualizationTarget(
          type: TargetType.nature,
          coverAssetPath: 'assets/images/targets/nature.png'),
      VisualizationTarget(
          type: TargetType.rest,
          coverAssetPath: 'assets/images/targets/rest.png'),
      VisualizationTarget(
          type: TargetType.sport,
          coverAssetPath: 'assets/images/targets/sport.png'),
      VisualizationTarget(
        type: TargetType.custom,
      ),
    ];
  }
}

enum TargetType { success, family, nature, sport, rest, custom }
