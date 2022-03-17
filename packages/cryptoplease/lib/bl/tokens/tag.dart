import 'package:json_annotation/json_annotation.dart';

part 'tag.g.dart';

@JsonSerializable(createToJson: false)
class Tag {
  const Tag({
    required this.name,
    required this.description,
  });

  factory Tag.fromJson(Map<String, dynamic> data) => _$TagFromJson(data);

  final String name;
  final String description;
}
