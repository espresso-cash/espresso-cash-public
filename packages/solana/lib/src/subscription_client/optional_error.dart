// ignore_for_file: no-object-declaration

import 'package:json_annotation/json_annotation.dart';

part 'optional_error.g.dart';

@JsonSerializable(createToJson: false)
class OptionalError {
  OptionalError({
    required this.err,
  });

  factory OptionalError.fromJson(Map<String, dynamic> json) =>
      _$OptionalErrorFromJson(json);

  Object? err;
}
