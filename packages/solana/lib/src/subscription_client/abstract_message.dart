import 'package:solana/src/subscription_client/error_message.dart';
import 'package:solana/src/subscription_client/notification_message.dart';
import 'package:solana/src/subscription_client/subscribed_message.dart';
import 'package:solana/src/subscription_client/unsubscribed_message.dart';

abstract class SubscriptionMessage {
  // All requests are matched to their responses by using the `id` specified
  // in the _jsonrpc_ call. According to section 4 of [JSON RPC 2.0](https://www.jsonrpc.org/specification)
  // specification this id is guaranteed to match the value sent in a given
  // request.
  factory SubscriptionMessage.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('method')) {
      // If 'method' is present in the json, it means that it is a notification
      // sent to the `${name}Notification` subscription.
      return NotificationMessage.fromJson(json);
    } else if (json.containsKey('result')) {
      // If 'result' is present it means that it is a "response" to a sent
      // request. There are 2 types of responses. When we call
      // `${something}Subscribe` we get one of these response types having
      // the subscription id in the `result` field and thus this field is a
      // `int` that can then bse used to unsubscribe.
      //
      // Upon unsubscribing, we get the second of these message types. In this
      // case the `result` is just a boolean that indicates whether or not the
      // call succeeded.
      if (json['result'] is int) {
        return SubscribedMessage.fromJson(json);
      } else if (json['result'] is bool) {
        return UnsubscribedMessage.fromJson(json);
      }

      throw const FormatException('cannot understand this message');
    } else if (json.containsKey('error')) {
      // If the 'error' field is present in the received json, it means a
      // request has failed.
      return ErrorMessage.fromJson(json);
    }

    throw const FormatException('cannot understand this message');
  }
}
