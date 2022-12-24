// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basic1.dart';

// **************************************************************************
// BorshSerializableGenerator
// **************************************************************************

mixin _$_AccountData {
  List<int> get discriminator => throw UnimplementedError();
  BigInt get data => throw UnimplementedError();

  Uint8List toBorsh() {
    final writer = BinaryWriter();

    const BFixedArray(8, BU8()).write(writer, discriminator);
    const BU64().write(writer, data);

    return writer.toArray();
  }
}

class __AccountData extends _AccountData {
  __AccountData({
    required this.discriminator,
    required this.data,
  }) : super._();

  final List<int> discriminator;
  final BigInt data;
}

class B_AccountData implements BType<_AccountData> {
  const B_AccountData();

  @override
  void write(BinaryWriter writer, _AccountData value) {
    writer.writeStruct(value.toBorsh());
  }

  @override
  _AccountData read(BinaryReader reader) {
    return _AccountData(
      discriminator: const BFixedArray(8, BU8()).read(reader),
      data: const BU64().read(reader),
    );
  }
}

_AccountData _$_AccountDataFromBorsh(Uint8List data) {
  final reader = BinaryReader(data.buffer.asByteData());

  return const B_AccountData().read(reader);
}

mixin _$Basic1Arguments {
  BigInt get data => throw UnimplementedError();

  Uint8List toBorsh() {
    final writer = BinaryWriter();

    const BU64().write(writer, data);

    return writer.toArray();
  }
}

class _Basic1Arguments extends Basic1Arguments {
  _Basic1Arguments({
    required this.data,
  }) : super._();

  final BigInt data;
}

class BBasic1Arguments implements BType<Basic1Arguments> {
  const BBasic1Arguments();

  @override
  void write(BinaryWriter writer, Basic1Arguments value) {
    writer.writeStruct(value.toBorsh());
  }

  @override
  Basic1Arguments read(BinaryReader reader) {
    return Basic1Arguments(
      data: const BU64().read(reader),
    );
  }
}

Basic1Arguments _$Basic1ArgumentsFromBorsh(Uint8List data) {
  final reader = BinaryReader(data.buffer.asByteData());

  return const BBasic1Arguments().read(reader);
}
