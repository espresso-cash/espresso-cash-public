part of 'spl_token.dart';

extension SPLTokenRPCExt on RPCClient {
  Future<List<AssociatedAccount>> getTokenAccountsByOwner(
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

    return AssociatedAccountResponse.fromJson(data).result.value;
  }
}
