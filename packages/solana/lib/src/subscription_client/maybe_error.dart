import 'package:json_annotation/json_annotation.dart';

part 'maybe_error.g.dart';

@JsonSerializable(createToJson: false)
class MaybeError {
  MaybeError({
    required this.err,
  });

  factory MaybeError.fromJson(Map<String, dynamic> json) =>
      _$MaybeErrorFromJson(json);

  Object? err;
}
