// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nonce_account.dart';

// **************************************************************************
// BorshSerializableGenerator
// **************************************************************************

mixin _$NonceAccount {
  int get version => throw UnimplementedError();
  int get state => throw UnimplementedError();
  Ed25519HDPublicKey get authorizedPubkey => throw UnimplementedError();
  Ed25519HDPublicKey get nonce => throw UnimplementedError();
  BigInt get lamportsPerSignature => throw UnimplementedError();

  Uint8List toBorsh() {
    final writer = BinaryWriter();

    const BU32().write(writer, version);
    const BU32().write(writer, state);
    const BPublicKey().write(writer, authorizedPubkey);
    const BPublicKey().write(writer, nonce);
    const BU64().write(writer, lamportsPerSignature);

    return writer.toArray();
  }
}

class _NonceAccount extends NonceAccount {
  _NonceAccount({
    required this.version,
    required this.state,
    required this.authorizedPubkey,
    required this.nonce,
    required this.lamportsPerSignature,
  }) : super._();

  final int version;
  final int state;
  final Ed25519HDPublicKey authorizedPubkey;
  final Ed25519HDPublicKey nonce;
  final BigInt lamportsPerSignature;
}

class BNonceAccount implements BType<NonceAccount> {
  const BNonceAccount();

  @override
  void write(BinaryWriter writer, NonceAccount value) {
    writer.writeStruct(value.toBorsh());
  }

  @override
  NonceAccount read(BinaryReader reader) {
    return NonceAccount(
      version: const BU32().read(reader),
      state: const BU32().read(reader),
      authorizedPubkey: const BPublicKey().read(reader),
      nonce: const BPublicKey().read(reader),
      lamportsPerSignature: const BU64().read(reader),
    );
  }
}

NonceAccount _$NonceAccountFromBorsh(Uint8List data) {
  final reader = BinaryReader(data.buffer.asByteData());

  return const BNonceAccount().read(reader);
}
