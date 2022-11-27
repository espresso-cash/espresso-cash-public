// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_metadata_account.dart';

// **************************************************************************
// BorshSerializableGenerator
// **************************************************************************

mixin _$CreateMetadataAccountV3Data {
  String get name => throw UnimplementedError();
  String get symbol => throw UnimplementedError();
  String get uri => throw UnimplementedError();
  int get sellerFeeBasisPoints => throw UnimplementedError();
  List<MetadataCreator>? get creators => throw UnimplementedError();
  MetadataCollection? get collection => throw UnimplementedError();
  MetadataUses? get uses => throw UnimplementedError();
  bool get isMutable => throw UnimplementedError();
  bool get colectionDetails => throw UnimplementedError();

  Uint8List toBorsh() {
    final writer = BinaryWriter();

    const BFixedString(32).write(writer, name);
    const BFixedString(10).write(writer, symbol);
    const BFixedString(200).write(writer, uri);
    const BU16().write(writer, sellerFeeBasisPoints);
    const BOption(BArray(BMetadataCreator())).write(writer, creators);
    const BOption(BMetadataCollection()).write(writer, collection);
    const BOption(BMetadataUses()).write(writer, uses);
    const BBool().write(writer, isMutable);
    const BBool().write(writer, colectionDetails);

    return writer.toArray();
  }
}

class _CreateMetadataAccountV3Data extends CreateMetadataAccountV3Data {
  _CreateMetadataAccountV3Data({
    required this.name,
    required this.symbol,
    required this.uri,
    required this.sellerFeeBasisPoints,
    this.creators,
    this.collection,
    this.uses,
    required this.isMutable,
    required this.colectionDetails,
  }) : super._();

  final String name;
  final String symbol;
  final String uri;
  final int sellerFeeBasisPoints;
  final List<MetadataCreator>? creators;
  final MetadataCollection? collection;
  final MetadataUses? uses;
  final bool isMutable;
  final bool colectionDetails;
}

class BCreateMetadataAccountV3Data
    implements BType<CreateMetadataAccountV3Data> {
  const BCreateMetadataAccountV3Data();

  @override
  void write(BinaryWriter writer, CreateMetadataAccountV3Data value) {
    writer.writeStruct(value.toBorsh());
  }

  @override
  CreateMetadataAccountV3Data read(BinaryReader reader) {
    return CreateMetadataAccountV3Data(
      name: const BFixedString(32).read(reader),
      symbol: const BFixedString(10).read(reader),
      uri: const BFixedString(200).read(reader),
      sellerFeeBasisPoints: const BU16().read(reader),
      creators: const BOption(BArray(BMetadataCreator())).read(reader),
      collection: const BOption(BMetadataCollection()).read(reader),
      uses: const BOption(BMetadataUses()).read(reader),
      isMutable: const BBool().read(reader),
      colectionDetails: const BBool().read(reader),
    );
  }
}

CreateMetadataAccountV3Data _$CreateMetadataAccountV3DataFromBorsh(
    Uint8List data) {
  final reader = BinaryReader(data.buffer.asByteData());

  return const BCreateMetadataAccountV3Data().read(reader);
}

mixin _$MetadataCreator {
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

class _MetadataCreator extends MetadataCreator {
  _MetadataCreator({
    required this.address,
    required this.verified,
    required this.share,
  }) : super._();

  final Ed25519HDPublicKey address;
  final bool verified;
  final int share;
}

class BMetadataCreator implements BType<MetadataCreator> {
  const BMetadataCreator();

  @override
  void write(BinaryWriter writer, MetadataCreator value) {
    writer.writeStruct(value.toBorsh());
  }

  @override
  MetadataCreator read(BinaryReader reader) {
    return MetadataCreator(
      address: const BPublicKey().read(reader),
      verified: const BBool().read(reader),
      share: const BU8().read(reader),
    );
  }
}

MetadataCreator _$MetadataCreatorFromBorsh(Uint8List data) {
  final reader = BinaryReader(data.buffer.asByteData());

  return const BMetadataCreator().read(reader);
}

mixin _$MetadataCollection {
  bool get verified => throw UnimplementedError();
  Ed25519HDPublicKey get key => throw UnimplementedError();

  Uint8List toBorsh() {
    final writer = BinaryWriter();

    const BBool().write(writer, verified);
    const BPublicKey().write(writer, key);

    return writer.toArray();
  }
}

class _MetadataCollection extends MetadataCollection {
  _MetadataCollection({
    required this.verified,
    required this.key,
  }) : super._();

  final bool verified;
  final Ed25519HDPublicKey key;
}

class BMetadataCollection implements BType<MetadataCollection> {
  const BMetadataCollection();

  @override
  void write(BinaryWriter writer, MetadataCollection value) {
    writer.writeStruct(value.toBorsh());
  }

  @override
  MetadataCollection read(BinaryReader reader) {
    return MetadataCollection(
      verified: const BBool().read(reader),
      key: const BPublicKey().read(reader),
    );
  }
}

MetadataCollection _$MetadataCollectionFromBorsh(Uint8List data) {
  final reader = BinaryReader(data.buffer.asByteData());

  return const BMetadataCollection().read(reader);
}

mixin _$MetadataUses {
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

class _MetadataUses extends MetadataUses {
  _MetadataUses({
    required this.useMethod,
    required this.remaining,
    required this.total,
  }) : super._();

  final int useMethod;
  final BigInt remaining;
  final BigInt total;
}

class BMetadataUses implements BType<MetadataUses> {
  const BMetadataUses();

  @override
  void write(BinaryWriter writer, MetadataUses value) {
    writer.writeStruct(value.toBorsh());
  }

  @override
  MetadataUses read(BinaryReader reader) {
    return MetadataUses(
      useMethod: const BU8().read(reader),
      remaining: const BU64().read(reader),
      total: const BU64().read(reader),
    );
  }
}

MetadataUses _$MetadataUsesFromBorsh(Uint8List data) {
  final reader = BinaryReader(data.buffer.asByteData());

  return const BMetadataUses().read(reader);
}
