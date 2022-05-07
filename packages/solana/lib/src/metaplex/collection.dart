import 'package:json_annotation/json_annotation.dart';

part 'collection.g.dart';

@JsonSerializable(createToJson: false)
class Collection {
  const Collection({
    required this.name,
    required this.family,
  });

  factory Collection.fromJson(Map<String, dynamic> json) =>
      _$CollectionFromJson(json);

  final String name;
  final String family;
}
