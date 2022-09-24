import 'package:borsh_annotation/borsh_annotation.dart';
import 'package:solana/solana.dart';
import 'package:solana/src/borsh_ext.dart';

part 'creator.g.dart';

@BorshSerializable()
class Creator with _$Creator {
  factory Creator({
    @BPublicKey() required Ed25519HDPublicKey address,
    @BBool() required bool verified,
    @BU8() required int share,
  }) = _Creator;

  const Creator._();

  factory Creator.fromBorsh(Uint8List data) => _$CreatorFromBorsh(data);
}
