import 'dart:async';
import 'dart:convert';

import 'package:solana/solana.dart';
import 'package:solana/src/json_rpc_client.dart';
import 'package:solana/src/solana_serializable/solana_serializable.dart'
    as solana_serializable;
import 'package:solana/src/solana_wallet.dart';
import 'package:solana/src/types/account_info.dart';
import 'package:solana/src/types/balance.dart';
import 'package:solana/src/types/blockhash.dart';
import 'package:solana/src/types/confirmed_signature.dart';
import 'package:solana/src/types/signature_status.dart';
import 'package:solana/src/types/simulate_tx_result.dart';
import 'package:solana/src/types/transaction.dart';
import 'package:solana/src/types/tx_signature.dart';
import 'package:solana/src/util/encode_int.dart';

const _two = 2;

/// Encapsulates the jsonrpc-2.0 protocol and implements the
/// Solana RPC API
class SolanaClient {
  /// Constructs a SolanaClient that is capable of sending various RPCs to
  /// [rpcUrl].
  SolanaClient(String rpcUrl) : _client = JsonRpcClient(rpcUrl);

  final JsonRpcClient _client;

  /// Returns the recent blockhash from the ledger, and a fee schedule that
  /// can be used to compute the cost of submitting transaction with
  /// the returned [Blockhash].
  Future<Blockhash> getRecentBlockhash() async {
    final data = await _client.request('getRecentBlockhash');

    return BlockhashResponse.fromJson(data).result.value;
  }

  /// Returns a Future that resolves the the balance of [address]
  Future<int> getBalance(String address) async {
    final data = await _client.request(
      'getBalance',
      params: <dynamic>[address],
    );

    return BalanceResponse.fromJson(data).result.value;
  }

  /// Returns a Future that resolves to the account related information
  /// for [address].
  Future<AccountInfo> getAccountInfo(String address) async {
    final data = await _client.request(
      'getAccountInfo',
      params: <dynamic>[
        address,
        <String, String>{'encoding': 'jsonParsed'}
      ],
    );

    return AccountInfoResponse.fromJson(data).result.value;
  }

  /// Prepares a transfer transaction by building a transfer program to transfer
  /// [amountInLamports] from [senderWallet] to [recipientAddress] and signing
  /// the resulting raw transaction.
  ///
  /// The returned object can be directly specified as parameter
  /// to the JSON-RPC-2.0 call in order to execute the signed program.
  Future<List<dynamic>> prepareTransfer(
    SolanaWallet senderWallet,
    String recipientAddress,
    int amountInLamports, {
    bool simulate = false,
  }) async {
    final Blockhash recentBlockhash = await getRecentBlockhash();
    final instruction = solana_serializable.Instruction(
      programIdIndex: 2,
      accountIndices: solana_serializable.CompactArray.fromList([0, 1]),
      data: solana_serializable.CompactArray.fromList(
        [
          ..._two.toSolanaBytes(32),
          ...amountInLamports.toSolanaBytes(64),
        ],
      ),
    );

    final message = solana_serializable.Message(
      header: solana_serializable.MessageHeader(1, 0, 1),
      accounts: solana_serializable.CompactArray.fromList([
        solana_serializable.Address.from(senderWallet.address),
        solana_serializable.Address.from(recipientAddress),
        solana_serializable.Address.from(solanaSystemProgramID),
      ]),
      recentBlockhash: recentBlockhash.blockhash,
      instructions: solana_serializable.CompactArray.fromList([instruction]),
    );
    final serializedMessage = message.serialize();

    final signature = solana_serializable.Signature.from(
        await senderWallet.sign(serializedMessage));

    final transaction = solana_serializable.Transaction(
      signatures: solana_serializable.CompactArray.fromList([signature]),
      message: message,
    );

    return <dynamic>[
      base64.encode(transaction.serialize()),
      <String, String>{
        'encoding': 'base64',
      }
    ];
  }

  /// Transfers [amountInLamports] from [senderWallet] to [recipientAddress].
  Future<TxSignature> transfer(
    SolanaWallet senderWallet,
    String recipientAddress,
    int amountInLamports,
  ) async {
    final data = await _client.request(
      'sendTransaction',
      params: await prepareTransfer(
        senderWallet,
        recipientAddress,
        amountInLamports,
      ),
    );

    return TxSignature(TxSignatureResponse.fromJson(data).result);
  }

  /// Simulates a transfer of [amountInLamports] from [senderWallet]
  /// to [recipientAddress].
  Future<SimulateTxResult> simulateTransfer(
    SolanaWallet senderWallet,
    String recipientAddress,
    int amountInLamports,
  ) async {
    final data = await _client.request(
      'simulateTransaction',
      params: await prepareTransfer(
        senderWallet,
        recipientAddress,
        amountInLamports,
      ),
    );

    return SimulateTxResultResponse.fromJson(data).result.value;
  }

  /// Requests an airdrop of [lamports] lamports to [address].
  Future<TxSignature> requestAirdrop(
    String address,
    int lamports, {
    String commitment = 'processed',
  }) async {
    final data = await _client.request('requestAirdrop', params: <dynamic>[
      address,
      lamports.toInt(),
      <String, String>{
        'commitment': commitment,
      },
    ]);

    return TxSignature(TxSignatureResponse.fromJson(data).result);
  }

  /// Returns Future that resolves to the statuses of a list of [signatures].
  /// Unless the [searchTransactionHistory] configuration parameter is included,
  /// this method only searches the recent status cache of signatures.
  Future<Iterable<SignatureStatus?>> getSignatureStatuses(
    List<TxSignature> signatures, {
    bool searchTransactionHistory = false,
  }) async {
    final data = await _client.request(
      'getSignatureStatuses',
      params: <dynamic>[
        [for (TxSignature signature in signatures) signature.toString()],
        <String, bool>{
          'searchTransactionHistory': searchTransactionHistory,
        }
      ],
    );

    return SignatureStatusesResponse.fromJson(data).result.value;
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
    TxSignature signature,
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

  /// Returns a Future that resolves to the most recent [limit] signatures
  /// that have been confirmed for a given [address].
  ///
  /// Providing [before] and [until] also moves the cursor to a more specific
  /// subset.
  Future<Iterable<ConfirmedSignature>> getConfirmedSignaturesForAddress2(
    String address, {
    int limit = 10,
    String? before,
    String? until,
  }) async {
    final data = await _client.request(
      'getConfirmedSignaturesForAddress2',
      params: <dynamic>[
        address,
        <String, dynamic>{
          'limit': limit,
          'before': before,
          'after': until,
        }
      ],
    );

    return ConfirmedSignaturesResponse.fromJson(data).result;
  }

  /// Returns a Future that resolves to the transaction details for a given
  /// [signature].
  Future<ConfirmedTransaction?> getConfirmedTransaction(
      String signature) async {
    final data = await _client.request(
      'getConfirmedTransaction',
      params: <dynamic>[signature, 'jsonParsed'],
    );
    return ConfirmedTransactionResponse.fromJson(data).result;
  }

  /// Get the [limit] most recent transactions for the [address] account
  Future<Iterable<ConfirmedTransaction?>> getTransactionsList(
    String address, {
    int limit = 10,
  }) async {
    final signatures = await getConfirmedSignaturesForAddress2(
      address,
      limit: limit,
    );
    final confirmedTransactions =
        signatures.map((s) => s.signature).map(getConfirmedTransaction);

    return Future.wait(confirmedTransactions);
  }
}
