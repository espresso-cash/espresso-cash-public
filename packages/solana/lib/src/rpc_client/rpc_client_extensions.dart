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
  Future<TransactionSignature> signAndSendTransaction(
    Message message,
    List<Ed25519HDKeyPair> signers,
  ) async {
    final recentBlockhash = await getRecentBlockhash();
    final signedTx = await signTransaction(recentBlockhash, message, signers);

    return sendTransaction(signedTx.encode());
  }

  /// This is just a helper function that allows the caller
  /// to wait for the transaction with signature [signature] to
  /// be in a desired [desiredStatus].
  ///
  /// Optionally a [timeout] can be specified and given that the state
  /// did not change to or past [desiredStatus] the method will
  /// throw an error.
  ///
  /// Note: the default [timeout] is 30 seconds.
  Future<void> waitForSignatureStatus(
    TransactionSignature signature,
    TxStatus desiredStatus, {
    Duration timeout = const Duration(seconds: 30),
  }) async {
    final completer = Completer<void>();
    final clock = Stopwatch();
    Future<void> check() async {
      if (clock.elapsed > timeout) {
        completer.completeError(
          TimeoutException(
            'Timed out waiting for the requested status $desiredStatus',
          ),
        );
        return;
      }
      final statuses = await getSignatureStatuses([signature]);
      final SignatureStatus? status = statuses.isEmpty ? null : statuses.first;
      if (status != null) {
        if (status.err != null) {
          completer.completeError(TransactionException(status.err!));
        } else if (status.confirmationStatus!.index >= desiredStatus.index) {
          completer.complete();
        } else {
          await Future<void>.delayed(const Duration(milliseconds: 2500));
          return check();
        }
      } else {
        await Future<void>.delayed(const Duration(milliseconds: 2500));
        return check();
      }
    }

    clock.start();
    // ignore: unawaited_futures
    check();

    return completer.future;
  }

  /// Get the [limit] most recent transactions for the [address] account
  ///
  /// For [commitment] parameter description [see this document][see this document]
  /// [Commitment.processed] is not supported as [commitment].
  ///
  /// [see this document]: https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment
  Future<Iterable<TransactionResponse>> getTransactionsList(
    String address, {
    int limit = 10,
    Commitment? commitment,
  }) async {
    // FIXME: this must be replaced soon
    // ignore: deprecated_member_use_from_same_package
    final signatures = await getConfirmedSignaturesForAddress2(
      address,
      limit: limit,
      commitment: commitment,
    );
    final transactions = await Future.wait(
      signatures.map(
        (s) => getConfirmedTransaction(s.signature, commitment: commitment),
      ),
    );

    // We are sure that no transaction in this list is `null` because
    // we have queried the signatures so they surely exist
    return transactions.whereType();
  }
}
