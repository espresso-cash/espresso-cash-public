import 'package:borsh_annotation/borsh_annotation.dart';
import 'package:solana/solana.dart';

class BPublicKey extends BType<Ed25519HDPublicKey> {
  const BPublicKey();

  @override
  Ed25519HDPublicKey read(BinaryReader reader) {
    final data = reader.readFixedArray(32, () => reader.readU8());

    return Ed25519HDPublicKey(data);
  }

  @override
  void write(BinaryWriter writer, Ed25519HDPublicKey value) {
    final data = value.bytes;
    writer.writeFixedArray<int>(data, writer.writeU8);
  }
}

class BBool extends BType<bool> {
  const BBool();

  @override
  void write(BinaryWriter writer, bool value) {
    writer.writeU8(value ? 1 : 0);
  }

  @override
  bool read(BinaryReader reader) => reader.readU8() != 0;
}
