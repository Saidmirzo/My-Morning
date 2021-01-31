import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class AudioFile extends Equatable {
  final String url;

  final File file;
  final String title;

  AudioFile({@required this.url, @required this.file, @required this.title});

  @override
  List<Object> get props => [url, title, file];
}
