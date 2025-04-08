// ignore_for_file: no-object-declaration

import 'package:json_annotation/json_annotation.dart';

part 'optional_error.g.dart';

@JsonSerializable()
class OptionalError {
  OptionalError({required this.err});

  factory OptionalError.fromJson(Map<String, dynamic> json) => _$OptionalErrorFromJson(json);

  Object? err;

  Map<String, dynamic> toJson() => _$OptionalErrorToJson(this);
}
