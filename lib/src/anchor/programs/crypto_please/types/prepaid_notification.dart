import 'dart:typed_data';

import 'package:borsh/borsh.dart';

part 'prepaid_notification.g.dart';

@Struct()
class PrepaidNotification extends BorshStruct {
  const PrepaidNotification({required this.notificationId});

  @string
  final String notificationId;

  @override
  List<int> toBorsh() => _PrepaidNotificationToBorsh(this);
}
