// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'raw_mint.dart';

// **************************************************************************
// BorshSerializableGenerator
// **************************************************************************

mixin _$RawMint {
  int get mintAuthorityOption => throw UnimplementedError();
  Ed25519HDPublicKey get mintAuthority => throw UnimplementedError();
  BigInt get supply => throw UnimplementedError();
  int get decimals => throw UnimplementedError();
  bool get isInitialized => throw UnimplementedError();
  int get freezeAuthorityOption => throw UnimplementedError();
  Ed25519HDPublicKey get freezeAuthority => throw UnimplementedError();

  Uint8List toBorsh() {
    final writer = BinaryWriter();

    const BU32().write(writer, mintAuthorityOption);
    const BPublicKey().write(writer, mintAuthority);
    const BU64().write(writer, supply);
    const BU8().write(writer, decimals);
    const BBool().write(writer, isInitialized);
    const BU32().write(writer, freezeAuthorityOption);
    const BPublicKey().write(writer, freezeAuthority);

    return writer.toArray();
  }
}

class _RawMint extends RawMint {
  _RawMint({
    required this.mintAuthorityOption,
    required this.mintAuthority,
    required this.supply,
    required this.decimals,
    required this.isInitialized,
    required this.freezeAuthorityOption,
    required this.freezeAuthority,
  }) : super._();

  final int mintAuthorityOption;
  final Ed25519HDPublicKey mintAuthority;
  final BigInt supply;
  final int decimals;
  final bool isInitialized;
  final int freezeAuthorityOption;
  final Ed25519HDPublicKey freezeAuthority;
}

class BRawMint implements BType<RawMint> {
  const BRawMint();

  @override
  void write(BinaryWriter writer, RawMint value) {
    writer.writeStruct(value.toBorsh());
  }

  @override
  RawMint read(BinaryReader reader) {
    return RawMint(
      mintAuthorityOption: const BU32().read(reader),
      mintAuthority: const BPublicKey().read(reader),
      supply: const BU64().read(reader),
      decimals: const BU8().read(reader),
      isInitialized: const BBool().read(reader),
      freezeAuthorityOption: const BU32().read(reader),
      freezeAuthority: const BPublicKey().read(reader),
    );
  }
}

RawMint _$RawMintFromBorsh(Uint8List data) {
  final reader = BinaryReader(data.buffer.asByteData());

  return const BRawMint().read(reader);
}
