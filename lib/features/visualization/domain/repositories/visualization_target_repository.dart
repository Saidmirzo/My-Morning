import 'package:morningmagic/features/visualization/domain/entities/target/visualization_target.dart';

abstract class VisualizationTargetRepository {
  Future <List<VisualizationTarget>> getVisualizationTargets();
  Future <void> saveVisualizationTargets(List<VisualizationTarget> targets);
}