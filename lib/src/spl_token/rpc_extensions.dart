import 'package:solana/src/rpc_client/commitment.dart';
import 'package:solana/src/rpc_client/rpc_client.dart';
import 'package:solana/src/spl_token/associated_account.dart';

extension SPLTokenRPCExt on RPCClient {
  Future<List<AssociatedTokenAccount>> getTokenAccountsByOwner(
    String address, {
    String? mint,
    String? programId,
    Commitment? commitment,
  }) async {
    final data = await client.request(
      'getTokenAccountsByOwner',
      params: <dynamic>[
        address,
        <String, String>{
          if (mint != null) 'mint': mint,
          if (programId != null) 'programId': programId,
        },
        <String, String>{
          'encoding': 'jsonParsed',
          if (commitment != null) 'commitment': commitment.value,
        }
      ],
    );

    return AssociatedTokenAccountResponse.fromJson(data).result.value;
  }
}
