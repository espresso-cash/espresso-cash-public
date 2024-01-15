import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/subscription_client/abstract_message.dart';
import 'package:solana/src/subscription_client/subscribe_error.dart';

part 'error_message.g.dart';

@JsonSerializable()
class ErrorMessage implements SubscriptionMessage {
  const ErrorMessage({
    required this.error,
    required this.id,
  });

  factory ErrorMessage.fromJson(Map<String, dynamic> json) =>
      _$ErrorMessageFromJson(json);

  final SubscribeError error;
  final int id;

  Map<String, dynamic> toJson() => _$ErrorMessageToJson(this);
}
