import 'package:solana/src/subscription_client/error_message.dart';
import 'package:solana/src/subscription_client/notification_message.dart';
import 'package:solana/src/subscription_client/subscribed_message.dart';

abstract class SubscriptionMessage {
  factory SubscriptionMessage.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('method')) {
      return NotificationMessage.fromJson(json);
    } else if (json.containsKey('result')) {
      return SubscribedMessage.fromJson(json);
    } else if (json.containsKey('error')) {
      return ErrorMessage.fromJson(json);
    } else {
      throw const FormatException('cannot understand this message');
    }
  }
}
