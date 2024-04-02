// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'metadata.dart';

// **************************************************************************
// BorshSerializableGenerator
// **************************************************************************

mixin _$Metadata {
  int get key => throw UnimplementedError();
  Ed25519HDPublicKey get updateAuthority => throw UnimplementedError();
  Ed25519HDPublicKey get mint => throw UnimplementedError();
  String get name => throw UnimplementedError();
  String get symbol => throw UnimplementedError();
  String get uri => throw UnimplementedError();
  int get sellerFeeBasisPoints => throw UnimplementedError();
  List<Creator>? get creators => throw UnimplementedError();
  bool get primarySaleHappened => throw UnimplementedError();
  bool get isMutable => throw UnimplementedError();
  int? get editionNonce => throw UnimplementedError();
  int? get tokenStandard => throw UnimplementedError();
  OnChainCollection? get collection => throw UnimplementedError();
  Uses? get uses => throw UnimplementedError();
  CollectionDetails? get collectionDetails => throw UnimplementedError();

  Uint8List toBorsh() {
    final writer = BinaryWriter();

    const BU8().write(writer, key);
    const BPublicKey().write(writer, updateAuthority);
    const BPublicKey().write(writer, mint);
    const BMetaString().write(writer, name);
    const BMetaString().write(writer, symbol);
    const BMetaString().write(writer, uri);
    const BU16().write(writer, sellerFeeBasisPoints);
    const BOption(BArray(BCreator())).write(writer, creators);
    const BBool().write(writer, primarySaleHappened);
    const BBool().write(writer, isMutable);
    const BOption(BU8()).write(writer, editionNonce);
    const BOption(BU8()).write(writer, tokenStandard);
    const BOption(BOnChainCollection()).write(writer, collection);
    const BOption(BUses()).write(writer, uses);
    const BOption(BCollectionDetails()).write(writer, collectionDetails);

    return writer.toArray();
  }
}

class _Metadata extends Metadata {
  _Metadata({
    required this.key,
    required this.updateAuthority,
    required this.mint,
    required this.name,
    required this.symbol,
    required this.uri,
    required this.sellerFeeBasisPoints,
    required this.creators,
    required this.primarySaleHappened,
    required this.isMutable,
    required this.editionNonce,
    required this.tokenStandard,
    required this.collection,
    required this.uses,
    required this.collectionDetails,
  }) : super._();

  final int key;
  final Ed25519HDPublicKey updateAuthority;
  final Ed25519HDPublicKey mint;
  final String name;
  final String symbol;
  final String uri;
  final int sellerFeeBasisPoints;
  final List<Creator>? creators;
  final bool primarySaleHappened;
  final bool isMutable;
  final int? editionNonce;
  final int? tokenStandard;
  final OnChainCollection? collection;
  final Uses? uses;
  final CollectionDetails? collectionDetails;
}

class BMetadata implements BType<Metadata> {
  const BMetadata();

  @override
  void write(BinaryWriter writer, Metadata value) {
    writer.writeStruct(value.toBorsh());
  }

  @override
  Metadata read(BinaryReader reader) {
    return Metadata(
      key: const BU8().read(reader),
      updateAuthority: const BPublicKey().read(reader),
      mint: const BPublicKey().read(reader),
      name: const BMetaString().read(reader),
      symbol: const BMetaString().read(reader),
      uri: const BMetaString().read(reader),
      sellerFeeBasisPoints: const BU16().read(reader),
      creators: const BOption(BArray(BCreator())).read(reader),
      primarySaleHappened: const BBool().read(reader),
      isMutable: const BBool().read(reader),
      editionNonce: const BOption(BU8()).read(reader),
      tokenStandard: const BOption(BU8()).read(reader),
      collection: const BOption(BOnChainCollection()).read(reader),
      uses: const BOption(BUses()).read(reader),
      collectionDetails: const BOption(BCollectionDetails()).read(reader),
    );
  }
}

Metadata _$MetadataFromBorsh(Uint8List data) {
  final reader = BinaryReader(data.buffer.asByteData());

  return const BMetadata().read(reader);
}
