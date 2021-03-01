import 'dart:async';
import 'dart:convert';

import 'package:solana_dart/solana_dart.dart';
import 'package:solana_dart/src/json_rpc_client.dart';
import 'package:solana_dart/src/solana_wallet.dart';
import 'package:solana_dart/src/types/account_info.dart';
import 'package:solana_dart/src/types/address.dart';
import 'package:solana_dart/src/types/blockhash.dart';
import 'package:solana_dart/src/types/common_tx.dart';
import 'package:solana_dart/src/types/compact_array.dart';
import 'package:solana_dart/src/types/confirmed_signature.dart';
import 'package:solana_dart/src/types/confirmed_signatures.dart';
import 'package:solana_dart/src/types/instruction.dart';
import 'package:solana_dart/src/types/message.dart';
import 'package:solana_dart/src/types/message_header.dart';
import 'package:solana_dart/src/types/signature.dart';
import 'package:solana_dart/src/types/signature_status.dart';
import 'package:solana_dart/src/types/signature_statuses.dart';
import 'package:solana_dart/src/types/transaction.dart';
import 'package:solana_dart/src/types/transaction_details.dart';
import 'package:solana_dart/src/types/transfer_result.dart';
import 'package:solana_dart/src/types/tx_signature.dart';
import 'package:solana_dart/src/util/encode_int.dart';

/// Encapsulates the jsonrpc-2.0 protocol and implements the
/// Solana RPC API
class SolanaClient {
  /// Constructs a SolanaClient that is capable of sending various RPCs to
  /// [rpcUrl]
  SolanaClient(String rpcUrl) {
    _client = JsonRpcClient(rpcUrl);
  }

  JsonRpcClient _client;

  /// Returns the recent blockhash from the ledger, and a fee schedule that
  /// can be used to compute the cost of submitting transaction with
  /// the returned [Blockhash]
  Future<Blockhash> getRecentBlockhash() {
    return _client.call('getRecentBlockhash');
  }

  /// Returns a Future that resolves the the balance of [address]
  Future<int> getBalance(String address) {
    return _client.call('getBalance', params: [address]);
  }

  /// Returns a Future that resolves to the account related information
  /// for [address]
  Future<AccountInfo> getAccountInfo(String address) {
    return _client.call(
      'getAccountInfo',
      params: [
        address,
        <String, String>{'encoding': 'jsonParsed'}
      ],
    );
  }

  Future<T> _transferHelper<T>(
      SolanaWallet senderWallet, String recipientAddress, int amountInLamports,
      [simulate = false]) async {
    final Blockhash recentBlockhash = await getRecentBlockhash();

    final Instruction instruction = Instruction(
      programIdIndex: 2,
      accountIndices: CompactArray.fromList([0, 1]),
      data: CompactArray.fromList(
        [
          ...encodeInt(2, 32),
          ...encodeInt(amountInLamports.toInt(), 64),
        ],
      ),
    );

    final Message message = Message(
      header: MessageHeader(1, 0, 1),
      accounts: CompactArray.fromList([
        Address.from(senderWallet.address),
        Address.from(recipientAddress),
        Address.from(SOLANA_SYSTEM_PROGRAM_ID),
      ]),
      recentBlockhash: recentBlockhash.blockhash,
      instructions: CompactArray.fromList([instruction]),
    );
    List<int> serializedMessage = message.serialize();

    Signature signature = Signature.from(
      await senderWallet.sign(
        serializedMessage,
      ),
    );

    Transaction transaction = Transaction(
      signatures: CompactArray.fromList([signature]),
      message: message,
    );

    return _client.call(
      simulate ? 'simulateTransaction' : 'sendTransaction',
      params: [
        base64.encode(transaction.serialize()),
        <String, String>{
          'encoding': 'base64',
        }
      ],
    );
  }

  /// Transfers [amountInLamports] from [senderWallet] to [recipientAddress]
  Future<TxSignature> transfer(SolanaWallet senderWallet,
      String recipientAddress, int amountInLamports) async {
    return _transferHelper(
        senderWallet, recipientAddress, amountInLamports, false);
  }

  /// Simulates a transfer of [amountInLamports] from [senderWallet]
  /// to [recipientAddress]
  Future<SimulateTxResult> simulateTransfer(SolanaWallet senderWallet,
      String recipientAddress, int amountInLamports) async {
    return _transferHelper(
        senderWallet, recipientAddress, amountInLamports, true);
  }

  /// Requests an airdrop of [lamports] lamports to [address]
  Future<TxSignature> requestAirdrop(String address, int lamports,
      [commitment = 'processed']) {
    return _client.call('requestAirdrop', params: [
      address,
      lamports.toInt(),
      <String, String>{
        'commitment': commitment,
      },
    ]);
  }

  /// Returns Future that resolves to the statuses of a list of [signatures].
  /// Unless the [searchTransactionHistory] configuration parameter is included,
  /// this method only searches the recent status cache of signatures.
  Future<SignatureStatuses> getSignatureStatuses(List<TxSignature> signatures,
      [searchTransactionHistory = false]) {
    return _client.call(
      'getSignatureStatuses',
      params: [
        [for (TxSignature signature in signatures) signature.toString()],
        <String, bool>{
          "searchTransactionHistory": searchTransactionHistory,
        }
      ],
    );
  }

  /// This is just a helper function that allows the caller
  /// to wait for the transaction with signature [signature] to
  /// be in a desired [desiredStatus].
  ///
  /// Optionally a [timeout] can be specified and given that the state
  /// did not change to or past [desiredStatus] the method will
  /// throw an error.
  ///
  /// Note: the default [timeout] is 30 seconds
  Future<void> waitForSignatureStatus(
      TxSignature signature, TxStatus desiredStatus,
      [timeout = const Duration(seconds: 30)]) async {
    Completer completer = Completer<void>();
    Stopwatch clock = Stopwatch();
    void check() async {
      if (clock.elapsed > timeout) {
        completer.completeError(
          'timed out waiting for the requested status $desiredStatus',
        );
        return;
      }
      final SignatureStatuses statuses =
          await getSignatureStatuses([signature]);
      final SignatureStatus status = statuses[0];
      if (status != null) {
        if (status.err != null) {
          completer.completeError(status.err);
        } else if (status.confirmationStatus.index >= desiredStatus.index) {
          completer.complete();
        } else {
          await Future.delayed(Duration(seconds: 5), () => {});
          check();
        }
      } else {
        await Future.delayed(Duration(seconds: 5), () => {});
        check();
      }
    }

    clock.start();
    check();

    return completer.future;
  }

  /// Returns a Future that resolves to the most recent [limit] signatures
  /// that have been confirmed for a given [address]
  ///
  /// Providing [before] and [until] also moves the cursor to a more specific
  /// subset
  Future<ConfirmedSignatures> getConfirmedSignaturesForAddress2(
    String address, {
    int limit = 10,
    String before,
    String until,
  }) {
    return _client.call(
      'getConfirmedSignaturesForAddress2',
      params: [
        address,
        <String, dynamic>{
          "limit": limit,
          "before": before,
          "after": until,
        }
      ],
    );
  }

  /// Returns a Future that resolves to the transaction details for a given
  /// [signature] in the specified [encoding]
  ///
  /// [encoding] can be `"json"`, `"jsonParsed"`, `"base58"` and `"base64"`.
  ///
  /// Here a brief description of the formats,
  ///
  /// - `"json"` (_default_) a simple json object
  /// - `"jsonParsed"` the instructions are made more human friendly
  /// - `"base64"` unparsed binary data
  /// - `"base58"` like `"base64"` but according to Solana docs it's slow
  Future<TransactionDetails> getConfirmedTransaction(
      String signature, String encoding) {
    return _client.call(
      'getConfirmedTransaction',
      params: [
        signature,
        encoding,
      ],
    );
  }

  /// Get the [limit] most recent transactions for the [address] account
  Future<List<CommonTx>> getTransactionsList(
    String address, {
    int limit = 10,
  }) async {
    final ConfirmedSignatures signatures =
        await getConfirmedSignaturesForAddress2(
      address,
      limit: limit,
    );
    List<CommonTx> list = List<CommonTx>();
    for (int index = 0; index < signatures.length; index++) {
      final ConfirmedSignature confirmedSignature = signatures[index];
      final TransactionDetails confirmedTx = await getConfirmedTransaction(
        confirmedSignature.signature,
        "jsonParsed",
      );
      list.addAll(confirmedTx.transactions);
    }
    return list;
  }
}
