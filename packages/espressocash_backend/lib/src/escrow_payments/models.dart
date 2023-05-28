import 'package:borsh_annotation/borsh_annotation.dart';

part 'models.g.dart';

@BorshSerializable()
class EscrowArgument with _$EscrowArgument {
  factory EscrowArgument({
    @BU64() required BigInt amount,
  }) = _EscrowArgument;

  const EscrowArgument._();

  factory EscrowArgument.fromBorsh(Uint8List data) =>
      _$EscrowArgumentFromBorsh(data);
}
