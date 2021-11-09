import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/dto/logs.dart';
import 'package:solana/src/dto/slot.dart';
import 'package:solana/src/rpc_client/rpc_types.dart';
import 'package:solana/src/subscription_client/notification_result.dart';
import 'package:solana/src/subscription_client/optional_error.dart';

part 'notification_params.freezed.dart';
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

  final NotificationResult<T> result;
  final int subscription;
}
