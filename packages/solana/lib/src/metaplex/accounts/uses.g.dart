// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'uses.dart';

// **************************************************************************
// BorshSerializableGenerator
// **************************************************************************

mixin _$Uses {
  int get useMethod => throw UnimplementedError();
  BigInt get remaining => throw UnimplementedError();
  BigInt get total => throw UnimplementedError();

  Uint8List toBorsh() {
    final writer = BinaryWriter();

    const BU8().write(writer, useMethod);
    const BU64().write(writer, remaining);
    const BU64().write(writer, total);

    return writer.toArray();
  }
}

class _Uses extends Uses {
  _Uses({
    required this.useMethod,
    required this.remaining,
    required this.total,
  }) : super._();

  final int useMethod;
  final BigInt remaining;
  final BigInt total;
}

class BUses implements BType<Uses> {
  const BUses();

  @override
  void write(BinaryWriter writer, Uses value) {
    writer.writeStruct(value.toBorsh());
  }

  @override
  Uses read(BinaryReader reader) {
    return Uses(
      useMethod: const BU8().read(reader),
      remaining: const BU64().read(reader),
      total: const BU64().read(reader),
    );
  }
}

Uses _$UsesFromBorsh(Uint8List data) {
  final reader = BinaryReader(data.buffer.asByteData());

  return const BUses().read(reader);
}
