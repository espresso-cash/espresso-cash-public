// ignore_for_file: prefer-typedefs-for-callbacks

import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/subscription_client/notification_context.dart';

part 'notification_result.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class NotificationResult<T> {
  const NotificationResult({
    required this.context,
    required this.value,
  });

  factory NotificationResult.fromJson(
    Map<String, dynamic> json,
    T Function(Object? object) fromJsonT,
  ) =>
      _$NotificationResultFromJson<T>(json, fromJsonT);

  final NotificationContext context;
  final T value;

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$NotificationResultToJson(this, toJsonT);
}
