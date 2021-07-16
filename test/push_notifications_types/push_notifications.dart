import 'dart:typed_data';

import 'package:borsh/borsh.dart';

part 'push_notifications.g.dart';

@Struct()
class Init extends BorshStruct {
  const Init({required this.fee});

  @u64
  final int fee;

  @override
  List<int> toBorsh() => _InitToBorsh(this);
}
