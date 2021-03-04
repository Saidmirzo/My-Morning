import 'package:morningmagic/features/visualization/domain/entities/visualization_image.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

abstract class VisualizationImageRepository {
  Future <List<VisualizationImage>> getVisualizationImages(String tag, int targetId);
  Future <void> cachePickedFromGalleryAssets(List<Asset> assetImages, int targetId);
}