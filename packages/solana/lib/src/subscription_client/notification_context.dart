import 'package:json_annotation/json_annotation.dart';

part 'notification_context.g.dart';

@JsonSerializable(createToJson: false)
class NotificationContext {
  const NotificationContext({
    required this.slot,
  });

  factory NotificationContext.fromJson(Map<String, dynamic> json) =>
      _$NotificationContextFromJson(json);

  final int slot;
}
