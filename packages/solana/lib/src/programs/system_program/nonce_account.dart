import 'package:borsh_annotation/borsh_annotation.dart';
import 'package:solana/solana.dart';

part 'nonce_account.g.dart';

@BorshSerializable()
abstract class NonceAccount with _$NonceAccount {
  factory NonceAccount({
    @BU32() required int version,
    @BU32() required int state,
    @BPublicKey() required Ed25519HDPublicKey authorizedPubkey,
    @BPublicKey() required Ed25519HDPublicKey nonce,
    @BU64() required BigInt lamportsPerSignature,
  }) = _NonceAccount;

  const NonceAccount._();

  factory NonceAccount.fromBorsh(Uint8List data) =>
      _$NonceAccountFromBorsh(data);
}
