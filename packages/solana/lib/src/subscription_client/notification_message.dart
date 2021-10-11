import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/src/subscription_client/abstract_message.dart';
import 'package:solana/src/subscription_client/notification_params.dart';
import 'package:solana/src/types/account.dart';

part 'notification_message.freezed.dart';
part 'notification_message.g.dart';

@Freezed(unionKey: 'method', fallbackUnion: 'unsupported')
class NotificationMessage
    with _$NotificationMessage
    implements SubscriptionMessage {
  const NotificationMessage._();

  const factory NotificationMessage.unsupported() = _UnsupportedNotification;

  const factory NotificationMessage.accountNotification({
    required NotificationParams<Account> params,
  }) = AccountNotification;

  factory NotificationMessage.fromJson(Map<String, dynamic> json) =>
      _$NotificationMessageFromJson(json);

  dynamic get data => maybeWhen(
        accountNotification: (params) => params.result.value,
        orElse: () => null,
      );

  int get subscription => maybeWhen(
        accountNotification: (params) => params.subscription,
        orElse: () => -1,
      );
}
