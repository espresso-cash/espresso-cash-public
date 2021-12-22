part of 'client.dart';

extension RpcClientExt on RpcClient {
  Future<String> signAndSendTransaction(
    Message message,
    List<Ed25519HDKeyPair> signers,
  ) async {
    final recentBlockhash = await getRecentBlockhash();
    final signedTx = await signTransaction(recentBlockhash, message, signers);

    return sendTransaction(signedTx.encode());
  }

  /// Get the [limit] most recent transactions for the [address] account
  ///
  /// For [commitment] parameter description [see this document][see this document]
  /// [Commitment.processed] is not supported as [commitment].
  ///
  /// [see this document]: https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment
  Future<Iterable<TransactionDetails>> getTransactionsList(
    String address, {
    int limit = 10,
    Commitment? commitment,
  }) async {
    final signatures = await getSignaturesForAddress(
      address,
      limit: limit,
      commitment: commitment,
    );
    final transactions = await Future.wait(
      signatures.map(
        (s) => getTransaction(
          s.signature,
          commitment: commitment,
          encoding: Encoding.jsonParsed,
        ),
      ),
    );

    // We are sure that no transaction in this list is `null` because
    // we have queried the signatures so they surely exist
    return transactions.whereType();
  }
}
