import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class MeditationAudio extends Equatable {
  final String id;
  final String url;

  final File file;

  MeditationAudio({
    @required this.id,
    @required this.url,
    @required this.file,
  });

  @override
  List<Object> get props => [url, id, file];
}
