import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/dto/logs.dart';
import 'package:solana/src/dto/slot.dart';
import 'package:solana/src/rpc_client/rpc_types.dart';
import 'package:solana/src/subscription_client/notification_result.dart';
import 'package:solana/src/subscription_client/optional_error.dart';

part 'notification_params.freezed.dart';
part 'notification_params.g.dart';

@freezed
class NotificationParamsSignature with _$NotificationParamsSignature {
  const factory NotificationParamsSignature({
    required NotificationResult<OptionalError> result,
    required int subscription,
  }) = _NotificationParamsSignature;

  factory NotificationParamsSignature.fromJson(Map<String, dynamic> json) =>
      _$NotificationParamsSignatureFromJson(json);
}

@freezed
class NotificationParamsLogs with _$NotificationParamsLogs {
  const factory NotificationParamsLogs({
    required NotificationResult<Logs> result,
    required int subscription,
  }) = _NotificationParamsLogs;

  factory NotificationParamsLogs.fromJson(Map<String, dynamic> json) =>
      _$NotificationParamsLogsFromJson(json);
}

@freezed
class NotificationParamsSlot with _$NotificationParamsSlot {
  const factory NotificationParamsSlot({
    required NotificationResult<Slot> result,
    required int subscription,
  }) = _NotificationParamsSlot;

  factory NotificationParamsSlot.fromJson(Map<String, dynamic> json) =>
      _$NotificationParamsSlotFromJson(json);
}

@freezed
class NotificationParamsAccount with _$NotificationParamsAccount {
  const factory NotificationParamsAccount({
    required NotificationResult<Account> result,
    required int subscription,
  }) = _NotificationParamsAccount;

  factory NotificationParamsAccount.fromJson(Map<String, dynamic> json) =>
      _$NotificationParamsAccountFromJson(json);
}

@freezed
class NotificationParamsGeneric with _$NotificationParamsGeneric {
  const factory NotificationParamsGeneric({
    required NotificationResult<Map<String, dynamic>> result,
    required int subscription,
  }) = _NotificationParamsGeneric;

  factory NotificationParamsGeneric.fromJson(Map<String, dynamic> json) =>
      _$NotificationParamsGenericFromJson(json);
}
