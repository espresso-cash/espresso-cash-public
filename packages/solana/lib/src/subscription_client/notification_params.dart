import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification_params.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class NotificationParams<T> {
  const NotificationParams({
    required this.result,
    required this.subscription,
  });

  factory NotificationParams.fromJson(
          Map<String, dynamic> json, T Function(Object? data) fromJsonT) =>
      _$NotificationParamsFromJson(json, fromJsonT);

  final T result;
  final int subscription;
}
