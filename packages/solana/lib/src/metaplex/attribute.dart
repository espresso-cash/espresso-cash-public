import 'package:json_annotation/json_annotation.dart';

part 'attribute.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Attribute {
  const Attribute({
    required this.traitType,
    required this.value,
  });

  factory Attribute.fromJson(Map<String, dynamic> json) =>
      _$AttributeFromJson(json);

  final String traitType;
  final dynamic value;

  Map<String, dynamic> toJson() => _$AttributeToJson(this);
}
