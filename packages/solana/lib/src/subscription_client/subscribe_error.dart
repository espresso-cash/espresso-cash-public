import 'package:json_annotation/json_annotation.dart';

part 'subscribe_error.g.dart';

@JsonSerializable()
class SubscribeError {
  const SubscribeError({
    required this.code,
    required this.message,
  });

  factory SubscribeError.fromJson(Map<String, dynamic> json) =>
      _$SubscribeErrorFromJson(json);

  final int code;
  final String message;

  Map<String, dynamic> toJson() => _$SubscribeErrorToJson(this);
}
