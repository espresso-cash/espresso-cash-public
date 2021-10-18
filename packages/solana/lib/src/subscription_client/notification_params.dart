import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/subscription_client/notification_result.dart';

part 'notification_params.g.dart';

@JsonSerializable(genericArgumentFactories: true, createToJson: false)
class NotificationParams<T> {
  const NotificationParams({
    required this.result,
    required this.subscription,
  });

  factory NotificationParams.fromJson(
    Map<String, dynamic> json,
    T Function(Object? object) fromJsonT,
  ) =>
      _$NotificationParamsFromJson<T>(json, fromJsonT);

  final NotificationResult<T> result;
  final int subscription;

  Map<String, dynamic> toJson() {
    throw UnsupportedError('it does not make sense to convert this to json');
  }
}
