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

  Map<String, dynamic> toJson() {
    throw UnsupportedError('it does not make sense to convert this to json');
  }
}
