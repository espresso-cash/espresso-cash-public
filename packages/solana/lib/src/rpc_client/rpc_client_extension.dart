part of 'rpc_client.dart';

/// These methods are not part of the RPC api so we are including them as
/// an extension instead.
extension Convenience on RPCClient {
  /// Convenience method to sign a transaction with [message] using [signers].
  /// Send the transaction after signing it.
  ///
  /// The first element of the [signers] array is considered to be the
  /// fee payer.
  ///
  /// For [commitment] parameter description [see this document][see this document]
  /// [Commitment.processed] is not supported as [commitment].
  ///
  /// [see this document]: https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment
  Future<String> signAndSendTransaction(
    Message message,
    List<Ed25519HDKeyPair> signers, {
    Commitment? commitment,
  }) async {
    final recentBlockhash = await getRecentBlockhash();
    final signedTx = await signTransaction(recentBlockhash, message, signers);

    return sendTransaction(
      transaction: signedTx.encode(),
      options: SendTransactionOptions(commitment: commitment),
    );
  }

  /// This is just a helper function that allows the caller
  /// to wait for the transaction with signature [signature] to
  /// be in a desired [desiredStatus].
  Future<void> waitForSignatureStatus(
    String signature,
    ConfirmationStatus desiredStatus,
  ) async {
    // Simply, if the returned result did not error out it means the desiredStatus
    // was fulfilled
    final optionalError = await _subscriptionClient
        .signatureSubscribe(signature, status: desiredStatus)
        .first;
    final error = optionalError.err;
    if (error != null) {
      throw Exception(error.toString());
    }
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
    // FIXME: this must be replaced soon
    // ignore: deprecated_member_use_from_same_package
    final signatures = await getConfirmedSignaturesForAddress2(
      pubKey: address,
      options: GetSignaturesForAddressOptions(
        limit: limit,
        commitment: commitment,
      ),
    );
    final transactions = await Future.wait(
      signatures.map(
        // ignore: deprecated_member_use_from_same_package
        (s) => getConfirmedTransaction(
          signature: s.signature,
          options: GetConfirmedTransactionOptions(
            commitment: commitment,
          ),
        ),
      ),
    );

    // We are sure that no transaction in this list is `null` because
    // we have queried the signatures so they surely exist
    return transactions.whereType();
  }
}
