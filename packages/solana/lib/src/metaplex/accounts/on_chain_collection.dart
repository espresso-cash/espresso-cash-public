import 'package:borsh_annotation/borsh_annotation.dart';
import 'package:solana/solana.dart';

part 'on_chain_collection.g.dart';

@BorshSerializable()
class OnChainCollection with _$OnChainCollection {
  factory OnChainCollection({
    @BBool() required bool verified,
    @BPublicKey() required Ed25519HDPublicKey key,
  }) = _OnChainCollection;

  const OnChainCollection._();

  factory OnChainCollection.fromBorsh(Uint8List data) =>
      _$OnChainCollectionFromBorsh(data);
}
