import 'dart:typed_data';

export 'package:solana/src/borsh_serializer/dynamic_container.dart'
    show DynamicContainer;
export 'package:solana/src/borsh_serializer/integer.dart' show BorshInteger;

abstract class BorshSerializable<T> {
  T deserialize(Uint8List data);
  Uint8List serialize();
}
