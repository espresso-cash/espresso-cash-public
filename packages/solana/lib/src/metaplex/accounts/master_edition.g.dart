// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'master_edition.dart';

// **************************************************************************
// BorshSerializableGenerator
// **************************************************************************

mixin _$MasterEdition {
  int get key => throw UnimplementedError();
  BigInt get supply => throw UnimplementedError();
  BigInt? get maxSupply => throw UnimplementedError();

  Uint8List toBorsh() {
    final writer = BinaryWriter();

    const BU8().write(writer, key);
    const BU64().write(writer, supply);
    const BOption(BU64()).write(writer, maxSupply);

    return writer.toArray();
  }
}

class _MasterEdition extends MasterEdition {
  _MasterEdition({
    required this.key,
    required this.supply,
    this.maxSupply,
  }) : super._();

  final int key;
  final BigInt supply;
  final BigInt? maxSupply;
}

class BMasterEdition implements BType<MasterEdition> {
  const BMasterEdition();

  @override
  void write(BinaryWriter writer, MasterEdition value) {
    writer.writeStruct(value.toBorsh());
  }

  @override
  MasterEdition read(BinaryReader reader) {
    return MasterEdition(
      key: const BU8().read(reader),
      supply: const BU64().read(reader),
      maxSupply: const BOption(BU64()).read(reader),
    );
  }
}

MasterEdition _$MasterEditionFromBorsh(Uint8List data) {
  final reader = BinaryReader(data.buffer.asByteData());

  return const BMasterEdition().read(reader);
}
