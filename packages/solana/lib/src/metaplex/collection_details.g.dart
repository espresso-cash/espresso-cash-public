// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_details.dart';

// **************************************************************************
// BorshSerializableGenerator
// **************************************************************************

mixin _$CollectionDetails {
  BigInt get size => throw UnimplementedError();

  Uint8List toBorsh() {
    final writer = BinaryWriter();

    const BU64().write(writer, size);

    return writer.toArray();
  }
}

class _CollectionDetails extends CollectionDetails {
  _CollectionDetails({
    required this.size,
  }) : super._();

  final BigInt size;
}

class BCollectionDetails implements BType<CollectionDetails> {
  const BCollectionDetails();

  @override
  void write(BinaryWriter writer, CollectionDetails value) {
    writer.writeStruct(value.toBorsh());
  }

  @override
  CollectionDetails read(BinaryReader reader) {
    return CollectionDetails(
      size: const BU64().read(reader),
    );
  }
}

CollectionDetails _$CollectionDetailsFromBorsh(Uint8List data) {
  final reader = BinaryReader(data.buffer.asByteData());

  return const BCollectionDetails().read(reader);
}
