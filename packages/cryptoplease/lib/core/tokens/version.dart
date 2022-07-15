import 'package:json_annotation/json_annotation.dart';

part 'version.g.dart';

@JsonSerializable(createToJson: false)
class Version {
  const Version({
    required this.major,
    required this.minor,
    required this.patch,
  });

  factory Version.fromJson(Map<String, dynamic> data) =>
      _$VersionFromJson(data);

  final int major;
  final int minor;
  final int patch;
}
