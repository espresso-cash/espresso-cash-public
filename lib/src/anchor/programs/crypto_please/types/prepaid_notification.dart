import 'dart:typed_data';

import 'package:solana/src/borsh/field_annotation.dart';
import 'package:solana/src/borsh/struct.dart';
import 'package:solana/src/borsh/struct_annotation.dart';

part 'prepaid_notification.g.dart';

@Struct()
class PrepaidNotification extends BorshStruct {
  const PrepaidNotification({required this.notificationId});

  @string
  final String notificationId;

  @override
  List<int> toBorsh() => _PrepaidNotificationToBorsh(this);
}
