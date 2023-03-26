// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// BorshSerializableGenerator
// **************************************************************************

mixin _$_EscrowDataAccount {
  Ed25519HDPublicKey get senderAccount => throw UnimplementedError();
  Ed25519HDPublicKey get vaultTokenAccount => throw UnimplementedError();
  Ed25519HDPublicKey get senderTokenAccount => throw UnimplementedError();
  Ed25519HDPublicKey get depositorAccount => throw UnimplementedError();
  int get status => throw UnimplementedError();

  Uint8List toBorsh() {
    final writer = BinaryWriter();

    const BPublicKey().write(writer, senderAccount);
    const BPublicKey().write(writer, vaultTokenAccount);
    const BPublicKey().write(writer, senderTokenAccount);
    const BPublicKey().write(writer, depositorAccount);
    const BU8().write(writer, status);

    return writer.toArray();
  }
}

class __EscrowDataAccount extends _EscrowDataAccount {
  __EscrowDataAccount({
    required this.senderAccount,
    required this.vaultTokenAccount,
    required this.senderTokenAccount,
    required this.depositorAccount,
    required this.status,
  }) : super._();

  final Ed25519HDPublicKey senderAccount;
  final Ed25519HDPublicKey vaultTokenAccount;
  final Ed25519HDPublicKey senderTokenAccount;
  final Ed25519HDPublicKey depositorAccount;
  final int status;
}

class B_EscrowDataAccount implements BType<_EscrowDataAccount> {
  const B_EscrowDataAccount();

  @override
  void write(BinaryWriter writer, _EscrowDataAccount value) {
    writer.writeStruct(value.toBorsh());
  }

  @override
  _EscrowDataAccount read(BinaryReader reader) {
    return _EscrowDataAccount(
      senderAccount: const BPublicKey().read(reader),
      vaultTokenAccount: const BPublicKey().read(reader),
      senderTokenAccount: const BPublicKey().read(reader),
      depositorAccount: const BPublicKey().read(reader),
      status: const BU8().read(reader),
    );
  }
}

_EscrowDataAccount _$_EscrowDataAccountFromBorsh(Uint8List data) {
  final reader = BinaryReader(data.buffer.asByteData());

  return const B_EscrowDataAccount().read(reader);
}

mixin _$EscrowArgument {
  BigInt get amount => throw UnimplementedError();

  Uint8List toBorsh() {
    final writer = BinaryWriter();

    const BU64().write(writer, amount);

    return writer.toArray();
  }
}

class _EscrowArgument extends EscrowArgument {
  _EscrowArgument({
    required this.amount,
  }) : super._();

  final BigInt amount;
}

class BEscrowArgument implements BType<EscrowArgument> {
  const BEscrowArgument();

  @override
  void write(BinaryWriter writer, EscrowArgument value) {
    writer.writeStruct(value.toBorsh());
  }

  @override
  EscrowArgument read(BinaryReader reader) {
    return EscrowArgument(
      amount: const BU64().read(reader),
    );
  }
}

EscrowArgument _$EscrowArgumentFromBorsh(Uint8List data) {
  final reader = BinaryReader(data.buffer.asByteData());

  return const BEscrowArgument().read(reader);
}
