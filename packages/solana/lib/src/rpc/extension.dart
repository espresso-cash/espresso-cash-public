part of 'client.dart';

extension RpcClientExt on RpcClient {
  Future<String> signAndSendTransaction(
    Message message,
    List<Ed25519HDKeyPair> signers, {
    FutureOr<void> Function(Signature)? onSigned,
  }) async {
    final recentBlockhash = await getRecentBlockhash();
    final signedTx = await signTransaction(recentBlockhash, message, signers);

    if (onSigned != null) {
      await onSigned(signedTx.signatures.first);
    }

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

    return _getTransactionsInBulk(
      signatures.where((s) => s.err == null).map((s) => s.signature),
    );
  }

  /// This method sends a `getTransaction` jsonrpc-2.0 request or rather,
  /// many of them in a single call. It also gets all the responses simultaneously
  /// and is of course much faster and efficient than requesting each signature
  /// separately.
  ///
  /// Ideally, we should have the ability to do this with all the RPC methods.
  ///
  /// Although I don't immediately see why that would be useful, it is a feature
  /// of the Json RPC api.
  Future<Iterable<TransactionDetails>> _getTransactionsInBulk(
    Iterable<String> signatures, {
    Commitment? commitment,
  }) async {
    final response = await jsonRpcClient.bulkRequest(
      'getTransaction',
      signatures
          .map((signature) => <dynamic>[
                signature,
                GetTransactionConfig(
                  encoding: Encoding.jsonParsed,
                  commitment: commitment,
                ).toJson(),
              ])
          .toList(growable: false),
    );
    final Iterable<dynamic> transactions = response.map(getResult);

    return transactions.map(
      (t) => TransactionDetails.fromJson(t as Map<String, dynamic>),
    );
  }
}
