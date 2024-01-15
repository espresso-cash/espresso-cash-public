import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/subscription_client/abstract_message.dart';

part 'unsubscribed_message.g.dart';

@JsonSerializable()
class UnsubscribedMessage implements SubscriptionMessage {
  const UnsubscribedMessage({
    required this.result,
    required this.id,
  });

  factory UnsubscribedMessage.fromJson(Map<String, dynamic> json) =>
      _$UnsubscribedMessageFromJson(json);

  final int result;
  final int id;

  Map<String, dynamic> toJson() => _$UnsubscribedMessageToJson(this);
}
