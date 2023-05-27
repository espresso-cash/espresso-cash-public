import 'package:borsh_annotation/borsh_annotation.dart';
import 'package:solana/dto.dart';
import 'package:solana/solana.dart';
import 'package:solana/src/metaplex/metaplex.dart';
import 'package:solana/src/metaplex/utils.dart';

extension GetMetaplexMetadata on RpcClient {
  Future<Metadata?> getMetadata({
    required Ed25519HDPublicKey mint,
    Commitment commitment = Commitment.finalized,
  }) async {
    final programAddress = await findMetaplexMetadataProgramAddress(mint);
    final account = await getAccountInfo(
      programAddress.toBase58(),
      encoding: Encoding.base64,
      commitment: commitment,
    ).value;
    if (account == null) {
      return null;
    }

    final data = account.data;

    return data is BinaryAccountData ? Metadata.fromBinary(data.data) : null;
  }

  Future<MasterEdition?> getMasterEdition({
    required Ed25519HDPublicKey mint,
    Commitment commitment = Commitment.finalized,
  }) async {
    final programAddress = await findMetaplexEditionProgramAddress(mint);
    final account = await getAccountInfo(
      programAddress.toBase58(),
      encoding: Encoding.base64,
      commitment: commitment,
    ).value;
    if (account == null) {
      return null;
    }

    final data = account.data;

    return data is BinaryAccountData
        ? MasterEdition.fromBorsh(Uint8List.fromList(data.data))
        : null;
  }
}
