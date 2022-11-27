import 'package:borsh_annotation/borsh_annotation.dart';
import 'package:solana/solana.dart';
import 'package:solana/src/metaplex/metaplex.dart';
import 'package:solana/src/metaplex/utils.dart';
import 'package:solana/src/rpc/dto/account_data/binary_account_data.dart';
import 'package:solana/src/rpc/dto/encoding.dart';

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
    );
    if (account == null) {
      return null;
    }

    final data = account.data;

    if (data is BinaryAccountData) {
      return Metadata.fromBinary(data.data);
    } else {
      return null;
    }
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
    );
    if (account == null) {
      return null;
    }

    final data = account.data;

    if (data is BinaryAccountData) {
      return MasterEdition.fromBorsh(Uint8List.fromList(data.data));
    } else {
      return null;
    }
  }
}
