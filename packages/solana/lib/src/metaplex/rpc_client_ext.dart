import 'package:solana/solana.dart';
import 'package:solana/src/encoder/buffer.dart';
import 'package:solana/src/metaplex/metaplex.dart';
import 'package:solana/src/rpc/dto/account_data/binary_account_data.dart';
import 'package:solana/src/rpc/dto/encoding.dart';

extension GetMetaplexMetadata on RpcClient {
  Future<Metadata?> getMetadata({
    required Ed25519HDPublicKey mint,
  }) async {
    final programAddress = await Ed25519HDPublicKey.findProgramAddress(
      seeds: [
        'metadata'.codeUnits,
        Buffer.fromBase58(metaplexMetadataProgramId),
        mint.toBuffer(),
      ],
      programId: Ed25519HDPublicKey.fromBase58(metaplexMetadataProgramId),
    );
    final account = await getAccountInfo(
      programAddress.toBase58(),
      encoding: Encoding.base64,
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
}
