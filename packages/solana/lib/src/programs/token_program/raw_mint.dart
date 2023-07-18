import 'package:borsh_annotation/borsh_annotation.dart';
import 'package:solana/solana.dart';

part 'raw_mint.g.dart';

@BorshSerializable()
class RawMint with _$RawMint {
  factory RawMint({
    @BU32() required int mintAuthorityOption,
    @BPublicKey() required Ed25519HDPublicKey mintAuthority,
    @BU64() required BigInt supply,
    @BU8() required int decimals,
    @BBool() required bool isInitialized,
    @BU32() required int freezeAuthorityOption,
    @BPublicKey() required Ed25519HDPublicKey freezeAuthority,
  }) = _RawMint;

  const RawMint._();

  factory RawMint.fromBorsh(Uint8List data) => _$RawMintFromBorsh(data);
}
