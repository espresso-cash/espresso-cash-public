// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creator.dart';

// **************************************************************************
// BorshSerializableGenerator
// **************************************************************************

mixin _$Creator {
  Ed25519HDPublicKey get address => throw UnimplementedError();
  bool get verified => throw UnimplementedError();
  int get share => throw UnimplementedError();

  Uint8List toBorsh() {
    final writer = BinaryWriter();

    const BPublicKey().write(writer, address);
    const BBool().write(writer, verified);
    const BU8().write(writer, share);

    return writer.toArray();
  }
}

class _Creator extends Creator {
  _Creator({
    required this.address,
    required this.verified,
    required this.share,
  }) : super._();

  final Ed25519HDPublicKey address;
  final bool verified;
  final int share;
}

class BCreator implements BType<Creator> {
  const BCreator();

  @override
  void write(BinaryWriter writer, Creator value) {
    writer.writeStruct(value.toBorsh());
  }

  @override
  Creator read(BinaryReader reader) {
    return Creator(
      address: const BPublicKey().read(reader),
      verified: const BBool().read(reader),
      share: const BU8().read(reader),
    );
  }
}

Creator _$CreatorFromBorsh(Uint8List data) {
  final reader = BinaryReader(data.buffer.asByteData());

  return const BCreator().read(reader);
}
