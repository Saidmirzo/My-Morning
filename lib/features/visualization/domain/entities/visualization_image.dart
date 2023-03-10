import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

abstract class VisualizationImage extends Equatable {
  final String path;
  final bool isDefault;

  const VisualizationImage({@required this.path, this.isDefault});
}

class VisualizationAssetImage extends VisualizationImage {
  const VisualizationAssetImage({@required String path, @required isDefault})
      : super(path: path, isDefault: isDefault);

  @override
  List<Object> get props => [path, isDefault];
}

class VisualizationGalleryImage extends VisualizationImage {
  final Asset pickedAsset;
  final ByteData byteData;

  const VisualizationGalleryImage(
      {@required String path,
      @required this.pickedAsset,
      @required this.byteData,
      @required isDefault})
      : super(path: path, isDefault: isDefault);

  @override
  List<Object> get props => [path, pickedAsset, byteData, isDefault];
}

class VisualizationFileSystemImage extends VisualizationImage {
  final File file;

  const VisualizationFileSystemImage(
      {@required String path, @required this.file, @required isDefault})
      : super(path: path, isDefault: isDefault);

  @override
  List<Object> get props => [path, file, isDefault];
}

class VisualizationNetworkImage extends VisualizationImage {
  const VisualizationNetworkImage({@required String path, @required isDefault})
      : super(path: path, isDefault: isDefault);

  @override
  List<Object> get props => [path, isDefault];
}
