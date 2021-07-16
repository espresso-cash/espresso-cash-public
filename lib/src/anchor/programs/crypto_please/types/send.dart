import 'dart:typed_data';

import 'package:borsh/borsh.dart';

part 'send.g.dart';

@Struct()
class Send extends BorshStruct {
  const Send({
    required this.notificationId,
    required this.messageType,
    required this.encryptedPayload,
  });

  @string
  final String notificationId;

  @string
  final String messageType;

  @string
  final String encryptedPayload;

  @override
  List<int> toBorsh() => _SendToBorsh(this);
}
