import 'package:json_annotation/json_annotation.dart';

part 'attribute.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class Attribute {
  const Attribute({
    required this.traitType,
    required this.value,
  });

  factory Attribute.fromJson(Map<String, dynamic> json) =>
      _$AttributeFromJson(json);

  final String traitType;
  final dynamic value;
}
