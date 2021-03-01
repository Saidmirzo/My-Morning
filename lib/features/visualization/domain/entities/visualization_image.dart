import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

abstract class VisualizationImage extends Equatable {
  final String path;

  VisualizationImage({@required this.path});
}

class VisualizationAssetImage extends VisualizationImage {
  VisualizationAssetImage({@required String path}) : super(path: path);

  @override
  List<Object> get props => [path];
}

class VisualizationGalleryImage extends VisualizationImage {
  final Asset pickedAsset;
  final ByteData byteData;

  VisualizationGalleryImage(
      {@required String path,
      @required this.pickedAsset,
      @required this.byteData})
      : super(path: path);

  @override
  List<Object> get props => [path, pickedAsset, byteData];
}

class VisualizationFileSystemImage extends VisualizationImage {
  final file;

  VisualizationFileSystemImage({@required String path, @required this.file})
      : super(path: path);

  @override
  List<Object> get props => [path, file];
}
