// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'on_chain_collection.dart';

// **************************************************************************
// BorshSerializableGenerator
// **************************************************************************

mixin _$OnChainCollection {
  bool get verified => throw UnimplementedError();
  Ed25519HDPublicKey get key => throw UnimplementedError();

  Uint8List toBorsh() {
    final writer = BinaryWriter();

    const BBool().write(writer, verified);
    const BPublicKey().write(writer, key);

    return writer.toArray();
  }
}

class _OnChainCollection extends OnChainCollection {
  _OnChainCollection({
    required this.verified,
    required this.key,
  }) : super._();

  final bool verified;
  final Ed25519HDPublicKey key;
}

class BOnChainCollection implements BType<OnChainCollection> {
  const BOnChainCollection();

  @override
  void write(BinaryWriter writer, OnChainCollection value) {
    writer.writeStruct(value.toBorsh());
  }

  @override
  OnChainCollection read(BinaryReader reader) {
    return OnChainCollection(
      verified: const BBool().read(reader),
      key: const BPublicKey().read(reader),
    );
  }
}

OnChainCollection _$OnChainCollectionFromBorsh(Uint8List data) {
  final reader = BinaryReader(data.buffer.asByteData());

  return const BOnChainCollection().read(reader);
}
