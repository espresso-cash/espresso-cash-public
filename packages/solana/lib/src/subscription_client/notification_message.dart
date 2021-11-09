import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/src/dto/logs.dart';
import 'package:solana/src/dto/slot.dart';
import 'package:solana/src/rpc_client/rpc_types.dart';
import 'package:solana/src/subscription_client/abstract_message.dart';
import 'package:solana/src/subscription_client/maybe_error.dart';
import 'package:solana/src/subscription_client/notification_params.dart';
import 'package:solana/src/subscription_client/notification_result.dart';

part 'notification_message.freezed.dart';
part 'notification_message.g.dart';

@Freezed(unionKey: 'method', fallbackUnion: 'unsupported')
class NotificationMessage
    with _$NotificationMessage
    implements SubscriptionMessage {
  const NotificationMessage._();

  const factory NotificationMessage.unsupported({
    required NotificationParams<dynamic> params,
  }) = _UnsupportedNotification;

  const factory NotificationMessage.accountNotification({
    required NotificationParams<NotificationResult<Account>> params,
  }) = AccountNotification;

  const factory NotificationMessage.logsNotification({
    required NotificationParams<NotificationResult<Logs>> params,
  }) = LogsNotification;

  const factory NotificationMessage.programNotification({
    required NotificationParams<NotificationResult<ProgramAccount>> params,
  }) = ProgramNotification;

  const factory NotificationMessage.signatureNotification({
    required NotificationParams<NotificationResult<MaybeError>> params,
  }) = SignatureNotification;

  const factory NotificationMessage.slotNotification({
    required NotificationParams<Slot> params,
  }) = SlotNotification;

  factory NotificationMessage.fromJson(Map<String, dynamic> data) =>
      _$NotificationMessageFromJson(data);

  /// Each of these objects has a `value` field and we want to
  /// use it to send it to the caller
  dynamic get value => when<dynamic>(
        accountNotification: (params) => params.result.value,
        logsNotification: (params) => params.result.value,
        programNotification: (params) => params.result.value,
        signatureNotification: (params) => params.result.value,
        slotNotification: (params) => params.result,
        unsupported: (params) => params.result,
      );

  int get subscription => when(
        accountNotification: (params) => params.subscription,
        logsNotification: (params) => params.subscription,
        programNotification: (params) => params.subscription,
        signatureNotification: (params) => params.subscription,
        slotNotification: (params) => params.subscription,
        unsupported: (params) => params.subscription,
      );
}
