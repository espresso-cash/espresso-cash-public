import 'package:json_annotation/json_annotation.dart';

part 'file.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class File {
  const File({
    required this.uri,
    required this.type,
    required this.cdn,
  });

  factory File.fromJson(Map<String, dynamic> json) => _$FileFromJson(json);

  final String uri;
  final String type;
  @JsonKey(defaultValue: false)
  final bool cdn;

  Map<String, dynamic> toJson() => _$FileToJson(this);
}
