import 'package:solana/solana.dart';
import 'package:solana/src/dto/logs.dart';
import 'package:solana/src/dto/program_filter.dart';
import 'package:solana/src/dto/slot.dart';
import 'package:solana/src/subscription_client/logs_filter.dart';
import 'package:solana/src/subscription_client/maybe_error.dart';
import 'package:solana/src/subscription_client/subscription_client.dart';

class SolanaClient extends RPCClient implements SubscriptionClient {
  SolanaClient({
    required String rpcUrl,
    required String websocketUrl,
  })  : _subscriptionClient = SubscriptionClient(websocketUrl),
        super(rpcUrl);

  final SubscriptionClient _subscriptionClient;

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
    final optionalError =
        await signatureSubscribe(signature, status: desiredStatus).first;
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
            encoding: Encoding.jsonParsed,
          ),
        ),
      ),
    );

    // We are sure that no transaction in this list is `null` because
    // we have queried the signatures so they surely exist
    return transactions.whereType();
  }

  @override
  void dispose() {
    _subscriptionClient.dispose();
  }

  @override
  Stream<Account> accountSubscribe(
    String address, {
    Commitment? commitment,
  }) =>
      _subscriptionClient.accountSubscribe(address, commitment: commitment);

  @override
  Stream<Logs> logsSubscribe(
    LogsFilter filter, {
    Commitment? commitment,
  }) =>
      _subscriptionClient.logsSubscribe(filter, commitment: commitment);

  @override
  Stream programSubscribe(
    String programId, {
    Encoding encoding = Encoding.jsonParsed,
    List<ProgramFilter>? filters,
    Commitment? commitment,
  }) =>
      _subscriptionClient.programSubscribe(
        programId,
        encoding: encoding,
        commitment: commitment,
      );

  @override
  Stream<int> rootSubscribe() => _subscriptionClient.rootSubscribe();

  @override
  Stream<MaybeError> signatureSubscribe(
    String signature, {
    Commitment? status,
  }) =>
      _subscriptionClient.signatureSubscribe(signature, status: status);

  @override
  Stream<Slot> slotSubscribe() => _subscriptionClient.slotSubscribe();
}
