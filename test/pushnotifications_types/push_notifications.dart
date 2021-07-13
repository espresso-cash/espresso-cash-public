import 'dart:typed_data';

import 'package:solana/src/borsh/field_annotation.dart';
import 'package:solana/src/borsh/struct.dart';
import 'package:solana/src/borsh/struct_annotation.dart';
import 'package:solana/src/borsh/type.dart';

part 'push_notifications.g.dart';

@Struct()
class Init extends BorshStruct {
  const Init({required this.fee});

  @u64
  final int fee;

  @override
  List<int> toBinary() => _InitToBorsh(this);
}
