import 'package:borsh_annotation/src/binary_reader.dart';
import 'package:borsh_annotation/src/binary_writer.dart';

class BorshSerializable {
  const BorshSerializable();
}

abstract class BType<T> {
  const BType();

  void write(BinaryWriter writer, T value);

  T read(BinaryReader reader);
}

class BString extends BType<String> {
  const BString();

  @override
  void write(BinaryWriter writer, String value) {
    writer.writeString(value);
  }

  @override
  String read(BinaryReader reader) => reader.readString();
}

class BU8 extends BType<int> {
  const BU8();

  @override
  void write(BinaryWriter writer, int value) {
    writer.writeU8(value);
  }

  @override
  int read(BinaryReader reader) => reader.readU8();
}

class BU16 extends BType<int> {
  const BU16();

  @override
  void write(BinaryWriter writer, int value) {
    writer.writeU16(value);
  }

  @override
  int read(BinaryReader reader) => reader.readU16();
}

class BU32 extends BType<int> {
  const BU32();

  @override
  void write(BinaryWriter writer, int value) {
    writer.writeU32(value);
  }

  @override
  int read(BinaryReader reader) => reader.readU32();
}

class BU64 extends BType<BigInt> {
  const BU64();

  @override
  void write(BinaryWriter writer, BigInt value) {
    writer.writeU64(value);
  }

  @override
  BigInt read(BinaryReader reader) => reader.readU64();
}

class BFixedArray<T> extends BType<List<T>> {
  const BFixedArray(this.length, this.type);

  final int length;
  final BType<T> type;

  @override
  void write(BinaryWriter writer, List<T> value) {
    writer.writeFixedArray<T>(value, (e) => type.write(writer, e));
  }

  @override
  List<T> read(BinaryReader reader) =>
      reader.readFixedArray(length, () => type.read(reader));
}

class BArray<T> extends BType<List<T>> {
  const BArray(this.type);

  final BType<T> type;

  @override
  void write(BinaryWriter writer, List<T> value) {
    writer.writeArray<T>(value, (e) => type.write(writer, e));
  }

  @override
  List<T> read(BinaryReader reader) =>
      reader.readArray(() => type.read(reader));
}

class BOption<T> extends BType<T?> {
  const BOption(this.type);

  final BType<T> type;

  @override
  T? read(BinaryReader reader) {
    final isSome = reader.readU8() == 1;

    return isSome ? type.read(reader) : null;
  }

  @override
  void write(BinaryWriter writer, T? value) {
    if (value == null) {
      writer.writeU8(0);
    } else {
      writer.writeU8(1);
      type.write(writer, value);
    }
  }
}
