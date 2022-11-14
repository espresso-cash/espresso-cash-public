part of 'client.dart';

extension RpcClientExt on RpcClient {
  Future<TransactionId> signAndSendTransaction(
    Message message,
    List<Ed25519HDKeyPair> signers, {
    FutureOr<void> Function(Signature)? onSigned,
    Commitment commitment = Commitment.finalized,
  }) async {
    final recentBlockhash = await getRecentBlockhash(commitment: commitment);
    final signedTx = await signTransaction(recentBlockhash, message, signers);

    if (onSigned != null) {
      await onSigned(signedTx.signatures.first);
    }

    return sendTransaction(
      signedTx.encode(),
      preflightCommitment: commitment,
    );
  }

  Future<SignedTx> signMessage(
    Message message,
    List<Ed25519HDKeyPair> signers, {
    RecentBlockhash? blockhash,
    Commitment commitment = Commitment.finalized,
  }) async {
    final recentBlockhash =
        blockhash ?? await getRecentBlockhash(commitment: commitment);

    return signTransaction(recentBlockhash, message, signers);
  }

  /// Get the [limit] most recent transactions for the [address] account
  ///
  /// For [commitment] parameter description [see this document][see this document]
  /// [Commitment.processed] is not supported as [commitment].
  ///
  /// [see this document]: https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment
  Future<Iterable<TransactionDetails>> getTransactionsList(
    Ed25519HDPublicKey address, {
    int limit = 10,
    String? before,
    String? until,
    Commitment? commitment,
    Encoding? encoding,
  }) async {
    final signatures = await getSignaturesForAddress(
      address.toBase58(),
      limit: limit,
      before: before,
      until: until,
      commitment: commitment,
    );

    if (signatures.isEmpty) return [];

    return getMultipleTransactions(
      signatures,
      commitment: commitment,
      encoding: encoding ?? Encoding.jsonParsed,
    );
  }

  /// Get multiple transactions in 1 call.
  ///
  /// Gets one transaction for each signature in the [signatures] list.
  ///
  /// The [encoding] and [commitment] parameters are "passed as is"
  /// to the internal call to [RpcClient.getTransaction()]
  Future<List<TransactionDetails>> getMultipleTransactions(
    List<TransactionSignatureInformation> signatures, {
    Commitment? commitment,
    Encoding? encoding,
  }) async {
    final response = await _jsonRpcClient.bulkRequest(
      'getTransaction',
      signatures
          .map(
            (s) => <dynamic>[
              s.signature,
              GetTransactionConfig(
                encoding: encoding,
                commitment: commitment,
              ).toJson(),
            ],
          )
          .toList(growable: false),
    );
    final Iterable<dynamic> transactions = response.map<dynamic>(getResult);

    return transactions
        .map(
          (dynamic t) => TransactionDetails.fromJson(t as Map<String, dynamic>),
        )
        .toList(growable: false);
  }
}
