import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(createToJson: false)
class EmptyNotification {
  EmptyNotification({
    required this.err,
  });

  Object? err;
}
