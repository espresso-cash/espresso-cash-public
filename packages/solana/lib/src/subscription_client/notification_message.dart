import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/src/subscription_client/abstract_message.dart';
import 'package:solana/src/subscription_client/notification_params.dart';

part 'notification_message.freezed.dart';
part 'notification_message.g.dart';

@Freezed(unionKey: 'method', fallbackUnion: 'unsupported')
class NotificationMessage
    with _$NotificationMessage
    implements SubscriptionMessage {
  const NotificationMessage._();

  const factory NotificationMessage.unsupported() = _UnsupportedNotification;

  const factory NotificationMessage.accountNotification({
    required NotificationParamsAccount params,
  }) = AccountNotification;

  const factory NotificationMessage.logsNotification({
    required NotificationParamsLogs params,
  }) = LogsNotification;

  const factory NotificationMessage.programNotification({
    required NotificationParamsGeneric params,
  }) = ProgramNotification;

  const factory NotificationMessage.signatureNotification({
    required NotificationParamsSignature params,
  }) = SignatureNotification;

  const factory NotificationMessage.slotNotification({
    required NotificationParamsSlot params,
  }) = SlotNotification;

  factory NotificationMessage.fromJson(Map<String, dynamic> json) =>
      _$NotificationMessageFromJson(json);

  /// Each of these objects has a `value` field and we want to
  /// use it to send it to the caller
  dynamic get value => when<dynamic>(
        accountNotification: (params) => params.result.value,
        logsNotification: (params) => params.result.value,
        programNotification: (params) => params.result.value,
        signatureNotification: (params) => params.result.value,
        slotNotification: (params) => params.result.value,
        unsupported: () => null,
      );

  int get subscription => when(
        accountNotification: (params) => params.subscription,
        logsNotification: (params) => params.subscription,
        programNotification: (params) => params.subscription,
        signatureNotification: (params) => params.subscription,
        slotNotification: (params) => params.subscription,
        unsupported: () => -1,
      );
}
