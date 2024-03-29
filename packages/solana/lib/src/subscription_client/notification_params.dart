// ignore_for_file: prefer-typedefs-for-callbacks

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/subscription_client/notification_result.dart';

part 'notification_params.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class NotificationParams<T> {
  const NotificationParams({
    required this.result,
    required this.subscription,
  });

  factory NotificationParams.fromJson(
    Map<String, dynamic> json,
    T Function(Object? data) fromJsonT,
  ) =>
      _$NotificationParamsFromJson(json, fromJsonT);

  final NotificationResult<T> result;
  final int subscription;

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$NotificationParamsToJson(this, toJsonT);
}
