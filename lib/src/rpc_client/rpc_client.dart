import 'dart:async';
import 'dart:convert';

import 'package:solana/src/crypto/ed25519_hd_keypair.dart';
import 'package:solana/src/encoder/message.dart';
import 'package:solana/src/encoder/signature.dart';
import 'package:solana/src/encoder/signed_tx.dart';
import 'package:solana/src/rpc_client/account.dart';
import 'package:solana/src/rpc_client/balance.dart';
import 'package:solana/src/rpc_client/blockhash.dart';
import 'package:solana/src/rpc_client/commitment.dart';
import 'package:solana/src/rpc_client/confirmed_signature.dart';
import 'package:solana/src/rpc_client/confirmed_transaction_response.dart';
import 'package:solana/src/rpc_client/get_transaction_response.dart';
import 'package:solana/src/rpc_client/json_rpc_client.dart';
import 'package:solana/src/rpc_client/minimum_balance_for_rent_exemption_response.dart';
import 'package:solana/src/rpc_client/signature_status.dart';
import 'package:solana/src/rpc_client/simulate_tx_result.dart';
import 'package:solana/src/rpc_client/transaction_response.dart';
import 'package:solana/src/rpc_client/transaction_signature.dart';
import 'package:solana/src/spl_token/token_amount.dart';
import 'package:solana/src/spl_token/token_supply.dart';

export 'account.dart' show Account;
export 'blockhash.dart' show Blockhash;
export 'commitment.dart' show Commitment;
export 'confirmed_signature.dart' show ConfirmedSignature;
export 'fee_calculator.dart';
export 'meta.dart' show Meta;
export 'parsed_instruction.dart';
export 'parsed_message.dart';
export 'parsed_spl_token_instruction.dart';
export 'parsed_system_instruction.dart';
export 'signature_status.dart' show SignatureStatus;
export 'transaction.dart' show Transaction;
export 'transaction_response.dart';

/// Encapsulates the jsonrpc-2.0 protocol and implements the
/// Solana RPC API
class RPCClient {
  /// Constructs a SolanaClient that is capable of sending various RPCs to
  /// [rpcUrl].
  RPCClient(String rpcUrl) : client = JsonRpcClient(rpcUrl);

  final JsonRpcClient client;

  /// Returns the recent blockhash from the ledger, and a fee schedule that
  /// can be used to compute the cost of submitting transaction with
  /// the returned [Blockhash].
  ///
  /// For [commitment] parameter description [see this document][see this document]
  /// [Commitment.processed] is not supported as [commitment].
  ///
  /// [see this document]: https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment
  Future<Blockhash> getRecentBlockhash({
    Commitment? commitment,
  }) async {
    final data = await client.request(
      'getRecentBlockhash',
      params: <dynamic>[
        if (commitment != null)
          <String, String>{'commitment': commitment.value},
      ],
    );

    return BlockhashResponse.fromJson(data).result.value;
  }

  /// Returns a Future that resolves the the balance of [address]
  ///
  /// For [commitment] parameter description [see this document][see this document]
  /// [Commitment.processed] is not supported as [commitment].
  ///
  /// [see this document]: https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment
  Future<int> getBalance(
    String address, {
    Commitment? commitment,
  }) async {
    final data = await client.request(
      'getBalance',
      params: <dynamic>[
        address,
        if (commitment != null)
          <String, String>{'commitment': commitment.value},
      ],
    );

    return BalanceResponse.fromJson(data).result.value;
  }

  /// Returns a Future that resolves to the account related information
  /// for [address].
  ///
  /// For [commitment] parameter description [see this document][see this document]
  /// [Commitment.processed] is not supported as [commitment].
  ///
  /// [see this document]: https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment
  Future<Account> getAccountInfo(
    String address, {
    Commitment? commitment,
  }) async {
    final data = await client.request(
      'getAccountInfo',
      params: <dynamic>[
        address,
        <String, String>{
          'encoding': 'jsonParsed',
          if (commitment != null) 'commitment': commitment.value,
        }
      ],
    );

    return AccountInfoResponse.fromJson(data).result.value;
  }

  /// Sends signed transaction [signedTx].
  ///
  /// For [commitment] parameter description [see this document][see this document]
  /// [Commitment.processed] is not supported as [commitment].
  ///
  /// [see this document]: https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment
  Future<TransactionSignature> sendTransaction(
    SignedTx signedTx, {
    Commitment? commitment,
  }) async {
    final data = await client.request(
      'sendTransaction',
      params: <dynamic>[
        base64.encode(signedTx.toList(growable: false)),
        <String, String>{
          'encoding': 'base64',
          if (commitment != null) 'commitment': commitment.value,
        }
      ],
    );

    return SignatureResponse.fromJson(data).result;
  }

  /// Simulates sending a signed transaction [signedTx].
  ///
  /// For [commitment] parameter description [see this document][see this document]
  /// [Commitment.processed] is not supported as [commitment].
  ///
  /// [see this document]: https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment
  Future<SimulateTxResult> simulateTransaction(
    SignedTx signedTx, {
    Commitment? commitment,
  }) async {
    final data = await client.request(
      'simulateTransaction',
      params: <dynamic>[
        base64.encode(signedTx.toList(growable: false)),
        <String, String>{
          'encoding': 'base64',
          if (commitment != null) 'commitment': commitment.value,
        }
      ],
    );

    return SimulateTxResultResponse.fromJson(data).result.value;
  }

  /// Requests an airdrop of [lamports] lamports to [address].
  Future<TransactionSignature> requestAirdrop({
    required String address,
    required int lamports,
    Commitment? commitment,
  }) async {
    final data = await client.request('requestAirdrop', params: <dynamic>[
      address,
      lamports.toInt(),
      if (commitment != null)
        <String, String>{
          'commitment': commitment.value,
        }
    ]);

    return SignatureResponse.fromJson(data).result;
  }

  /// Returns a Future that resolves to the most recent [limit] signatures
  /// that have been confirmed for a given [address].
  ///
  /// Providing [before] and [until] also moves the cursor to a more specific
  /// subset.
  ///
  /// For [commitment] parameter description [see this document][see this document]
  /// [Commitment.processed] is not supported as [commitment].
  ///
  /// [see this document]: https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment
  @Deprecated('Should be replaced with `getConfirmedSignaturesForAddress` soon')
  Future<Iterable<ConfirmedSignature>> getConfirmedSignaturesForAddress2(
    String address, {
    int limit = 10,
    String? before,
    String? until,
    Commitment? commitment,
  }) async {
    final data = await client.request(
      'getConfirmedSignaturesForAddress2',
      params: <dynamic>[
        address,
        <String, dynamic>{
          'limit': limit,
          'before': before,
          'after': until,
          if (commitment != null) 'commitment': commitment.value,
        }
      ],
    );

    return ConfirmedSignaturesResponse.fromJson(data).result;
  }

  /// Returns a Future that resolves to the transaction details for a given
  /// [signature].
  ///
  /// For [commitment] parameter description [see this document][see this document]
  /// [Commitment.processed] is not supported as [commitment].
  ///
  /// [see this document]: https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment
  Future<TransactionResponse?> getConfirmedTransaction(
    String signature, {
    Commitment? commitment,
  }) async {
    final data = await client.request(
      'getConfirmedTransaction',
      params: <dynamic>[
        signature,
        {
          'encoding': 'jsonParsed',
          if (commitment != null) 'commitment': commitment.value,
        }
      ],
    );

    return ConfirmedTransactionResponse.fromJson(data).result;
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

  /// Returns transaction details for a confirmed transaction with
  /// signature [signature]
  ///
  /// For [commitment] parameter description [see this document][see this document]
  /// [Commitment.processed] is not supported as [commitment].
  ///
  /// [see this document]: https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment
  Future<TransactionResponse?> getTransaction(
    String signature, {
    Commitment? commitment,
  }) async {
    final data = await client.request(
      'getTransaction',
      params: <dynamic>[
        signature.toString(),
        <String, dynamic>{
          'encoding': 'jsonParsed',
          if (commitment != null) 'commitment': commitment.value,
        }
      ],
    );

    return GetTransactionResponse.fromJson(data).result;
  }

  /// Get token supply for [tokenMintAddress]
  ///
  /// For [commitment] parameter description [see this document][see this document]
  /// [Commitment.processed] is not supported as [commitment].
  ///
  /// [see this document]: https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment
  Future<TokenSupplyResult> getTokenSupply(
    String tokenMintAddress, {
    Commitment commitment = Commitment.confirmed,
  }) async {
    final data = await client.request(
      'getTokenSupply',
      params: <dynamic>[
        tokenMintAddress,
        <String, dynamic>{
          'encoding': 'jsonParsed',
          'commitment': commitment.value,
        }
      ],
    );

    return GetTokenSupplyResponse.fromJson(data).result;
  }

  /// Returns Future that resolves to the statuses of a list of [signatures].
  /// Unless the [searchTransactionHistory] configuration parameter is included,
  /// this method only searches the recent status cache of signatures.
  Future<Iterable<SignatureStatus?>> getSignatureStatuses(
    List<TransactionSignature> signatures, {
    bool searchTransactionHistory = false,
  }) async {
    final data = await client.request(
      'getSignatureStatuses',
      params: <dynamic>[
        [
          for (TransactionSignature signature in signatures)
            signature.toString()
        ],
        <String, bool>{
          'searchTransactionHistory': searchTransactionHistory,
        }
      ],
    );

    return SignatureStatusesResponse.fromJson(data).result.value;
  }

  /// Get minimum balance for ren exemption to allocate [size] bytes
  /// in an account.
  ///
  /// For [commitment] parameter description [see this document][see this document]
  /// [Commitment.processed] is not supported as [commitment].
  ///
  /// [see this document]: https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment
  Future<int> getMinimumBalanceForRentExemption(
    int size, {
    Commitment? commitment,
  }) async {
    final data = await client.request(
      'getMinimumBalanceForRentExemption',
      params: <dynamic>[
        size,
        if (commitment != null)
          <String, String>{'commitment': commitment.value},
      ],
    );

    return MinimumBalanceForRentExemptionResponse.fromJson(data).result;
  }

  Future<TokenAmount> getTokenAccountBalance({
    required String associatedTokenAccountAddress,
    Commitment? commitment,
  }) async {
    final data = await client.request(
      'getTokenAccountBalance',
      params: <dynamic>[
        associatedTokenAccountAddress,
        if (commitment != null)
          <String, String>{'commitment': commitment.value},
      ],
    );

    return TokenBalanceResponse.fromJson(data).result.value;
  }

  /// Convenience method to sign a transaction with [message] using [signers].
  /// Send the transaction after signing it.
  ///
  /// The [feePayer] will pay for the transaction fee if provided as the [feePayer]
  /// parameter and the corresponding signer is the first item of the [signers]
  /// list.
  ///
  /// For [commitment] parameter description [see this document][see this document]
  /// [Commitment.processed] is not supported as [commitment].
  ///
  /// [see this document]: https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment
  Future<TransactionSignature> signAndSendTransaction(
    Message message,
    List<Ed25519HDKeyPair> signers, {
    String? feePayer,
    Commitment? commitment,
  }) async {
    final int numSignaturesCount = message.countRequiredSignatures(feePayer);
    if (signers.length != numSignaturesCount) {
      throw FormatException(
        'your message requires $numSignaturesCount signatures but '
        'you provided ${signers.length}',
      );
    }
    final recentBlockhash = await getRecentBlockhash();
    final messageBytes = message.compile(
      recentBlockhash: recentBlockhash.blockhash,
      feePayer: feePayer ?? signers[0].address,
    );
    // FIXME(IA): signatures must match signers in the message accounts sorting
    final List<Signature> signatures = await Future.wait(
      signers.map((wallet) => wallet.sign(messageBytes)),
    );
    final signature = await sendTransaction(
      SignedTx(
        messageBytes: messageBytes,
        signatures: signatures,
      ),
      commitment: commitment,
    );
    await waitForSignatureStatus(signature, commitment ?? TxStatus.finalized);

    return signature;
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
          'timed out waiting for the requested status $desiredStatus',
        );
        return;
      }
      final statuses = await getSignatureStatuses([signature]);
      final SignatureStatus? status = statuses.isEmpty ? null : statuses.first;
      if (status != null) {
        if (status.err != null) {
          completer.completeError(status.err!);
        } else if (status.confirmationStatus!.index >= desiredStatus.index) {
          completer.complete();
        } else {
          await Future<void>.delayed(const Duration(seconds: 5));
          return check();
        }
      } else {
        await Future<void>.delayed(const Duration(seconds: 5));
        return check();
      }
    }

    clock.start();
    // ignore: unawaited_futures
    check();

    return completer.future;
  }
}
