import 'package:easy_localization/easy_localization.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/features/visualization/domain/entities/image_tag.dart';
import 'package:morningmagic/features/visualization/domain/entities/target/visualization_target.dart';
import 'package:morningmagic/features/visualization/domain/repositories/visualization_target_repository.dart';

class VisualizationTargetRepositoryImpl
    implements VisualizationTargetRepository {
  @override
  Future<List<VisualizationTarget>> getVisualizationTargets() async {
    print('repository :: get visualization targets');
    final List<VisualizationTarget> result = [];
    final _targets =
        await MyDB().getBox().get(MyResource.VISUALIZTION_TARGETS_KEY);
    if (_targets == null) {
      print('local targets is null :: get defaults');
      final _defaultTargets = _generateDefaultTargets();
      result.addAll(_defaultTargets);
      saveVisualizationTargets(_defaultTargets);
    } else {
      print('local targets not null :: get from local store');
      final List<VisualizationTarget> _locallySavedTargets =
          _targets.cast<VisualizationTarget>();
      result.addAll(_locallySavedTargets);
    }

    return Future.value(result);
  }

  @override
  Future<void> saveVisualizationTargets(List<VisualizationTarget> targets) {
    return MyDB().getBox().put(MyResource.VISUALIZTION_TARGETS_KEY, targets);
  }

  List<VisualizationTarget> _generateDefaultTargets() {
    return [
      // TODO translations
      VisualizationTarget(
          id: 0,
          tag: EnumToString.convertToString(VisualizationImageTag.success),
          title: 'success_target'.tr(),
          coverAssetPath: 'assets/images/targets/success.png'),
      VisualizationTarget(
          id: 1,
          tag: EnumToString.convertToString(VisualizationImageTag.family),
          title: 'family_target'.tr(),
          coverAssetPath: 'assets/images/targets/family.png'),
      VisualizationTarget(
          id: 2,
          title: 'nature_target'.tr(),
          tag: EnumToString.convertToString(VisualizationImageTag.nature),
          coverAssetPath: 'assets/images/targets/nature.png'),
      VisualizationTarget(
          id: 3,
          title: 'rest_target'.tr(),
          tag: EnumToString.convertToString(VisualizationImageTag.rest),
          coverAssetPath: 'assets/images/targets/rest.png'),
      VisualizationTarget(
          id: 4,
          title: 'sport_target'.tr(),
          tag: EnumToString.convertToString(VisualizationImageTag.sport),
          coverAssetPath: 'assets/images/targets/sport.png'),
    ];
  }
}
