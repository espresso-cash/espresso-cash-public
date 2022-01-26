import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/src/metaplex/file.dart';

part 'properties.freezed.dart';
part 'properties.g.dart';

@Freezed(unionKey: 'category', fallbackUnion: 'unknown')
class Properties with _$Properties {
  const factory Properties.unknown() = Unknown;

  const factory Properties.video({
    required List<File> files,
  }) = Video;

  const factory Properties.image({
    required List<File> files,
  }) = Image;

  const factory Properties.vr({
    required List<File> files,
  }) = Model3D;

  const factory Properties.audio({
    required List<File> files,
  }) = Audio;

  const factory Properties.html({
    required List<File> files,
  }) = Html;

  factory Properties.fromJson(Map<String, dynamic> json) =>
      _$PropertiesFromJson(json);
}
