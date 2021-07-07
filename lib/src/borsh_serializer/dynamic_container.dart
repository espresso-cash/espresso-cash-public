import 'dart:typed_data';

import 'package:solana/src/borsh_serializer/borsh_serializer.dart';

class DynamicContainer<T> implements BorshSerializable<DynamicContainer<T>> {
  @override
  DynamicContainer<T> deserialize(Uint8List data) {
    throw UnimplementedError();
  }

  @override
  Uint8List serialize() {
    throw UnimplementedError();
  }
}
