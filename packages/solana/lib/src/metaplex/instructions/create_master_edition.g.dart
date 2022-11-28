// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_master_edition.dart';

// **************************************************************************
// BorshSerializableGenerator
// **************************************************************************

mixin _$CreateMasterEditionV3Data {
  BigInt? get maxSupply => throw UnimplementedError();

  Uint8List toBorsh() {
    final writer = BinaryWriter();

    const BOption(BU64()).write(writer, maxSupply);

    return writer.toArray();
  }
}

class _CreateMasterEditionV3Data extends CreateMasterEditionV3Data {
  _CreateMasterEditionV3Data({
    this.maxSupply,
  }) : super._();

  final BigInt? maxSupply;
}

class BCreateMasterEditionV3Data implements BType<CreateMasterEditionV3Data> {
  const BCreateMasterEditionV3Data();

  @override
  void write(BinaryWriter writer, CreateMasterEditionV3Data value) {
    writer.writeStruct(value.toBorsh());
  }

  @override
  CreateMasterEditionV3Data read(BinaryReader reader) {
    return CreateMasterEditionV3Data(
      maxSupply: const BOption(BU64()).read(reader),
    );
  }
}

CreateMasterEditionV3Data _$CreateMasterEditionV3DataFromBorsh(Uint8List data) {
  final reader = BinaryReader(data.buffer.asByteData());

  return const BCreateMasterEditionV3Data().read(reader);
}
