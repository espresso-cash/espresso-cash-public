import 'dart:typed_data';

import 'package:solana/src/borsh_serializer/borsh_serializer.dart';

class Struct implements BorshSerializable<Struct> {
  Struct.fromMap(Map<String, BorshSerializable> map) : _raw = map;

  @override
  Struct deserialize(Uint8List data) {
    throw UnimplementedError();
  }

  @override
  Uint8List serialize() {
    throw UnimplementedError();
  }

  final Map<String, dynamic> _raw;
}
