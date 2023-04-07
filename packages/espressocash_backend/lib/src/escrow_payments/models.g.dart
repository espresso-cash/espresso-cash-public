// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// BorshSerializableGenerator
// **************************************************************************

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
