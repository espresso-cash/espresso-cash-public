import 'dart:convert';

import 'package:crypto_please_solana_lib/crypto_please_solana_lib.dart';
import 'package:crypto_please_solana_lib/src/json_rpc_client.dart';
import 'package:crypto_please_solana_lib/src/solana_wallet.dart';
import 'package:crypto_please_solana_lib/src/types/account_info.dart';
import 'package:crypto_please_solana_lib/src/types/blockhash.dart';
import 'package:crypto_please_solana_lib/src/types/compact_array.dart';
import 'package:crypto_please_solana_lib/src/types/instruction.dart';
import 'package:crypto_please_solana_lib/src/types/message.dart';
import 'package:crypto_please_solana_lib/src/types/message_header.dart';
import 'package:crypto_please_solana_lib/src/types/serializable_address.dart';
import 'package:crypto_please_solana_lib/src/types/serializable_signature.dart';
import 'package:crypto_please_solana_lib/src/types/signature_status.dart';
import 'package:crypto_please_solana_lib/src/types/transaction.dart';
import 'package:crypto_please_solana_lib/src/types/transfer_result.dart';
import 'package:crypto_please_solana_lib/src/types/tx_signature.dart';
import 'package:crypto_please_solana_lib/src/util/encode_int.dart';

class SolanaClient {
  SolanaClient(String rpcUrl) {
    _client = JsonRpcClient(rpcUrl);
  }

  JsonRpcClient _client;

  Future<Blockhash> getRecentBlockhash() {
    return _client.call('getRecentBlockhash');
  }

  Future<BigInt> getBalance(String address, [commitment = 'processed']) {
    return _client.call('getBalance', params: [
      address,
      <String, String>{
        'commitment': commitment,
      },
    ]);
  }

  Future<AccountInfo> getAccountInfo(String address) {
    return _client.call(
      'getAccountInfo',
      params: [
        address,
        <String, String>{'encoding': 'jsonParsed'}
      ],
    );
  }

  Future<T> _transferHelper<T>(SolanaWallet senderWallet,
      String recipientAddress, BigInt amountInLamports,
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
        SerializableAddress.from(senderWallet.address),
        SerializableAddress.from(recipientAddress),
        SerializableAddress.from(SOLANA_SYSTEM_PROGRAM_ID),
      ]),
      recentBlockhash: recentBlockhash.blockhash,
      instructions: CompactArray.fromList([instruction]),
    );
    List<int> serializedMessage = message.serialize();

    SerializableSignature signature = SerializableSignature.from(
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

  Future<TxSignature> transfer(SolanaWallet senderWallet,
      String recipientAddress, BigInt amountInLamports) async {
    return _transferHelper(
        senderWallet, recipientAddress, amountInLamports, false);
  }

  Future<SimulateTxResult> simulateTransfer(SolanaWallet senderWallet,
      String recipientAddress, BigInt amountInLamports) async {
    return _transferHelper(
        senderWallet, recipientAddress, amountInLamports, true);
  }

  Future<TxSignature> requestAirdrop(String address, BigInt lamports,
      [commitment = 'processed']) {
    return _client.call('requestAirdrop', params: [
      address,
      lamports.toInt(),
      <String, String>{
        'commitment': commitment,
      },
    ]);
  }

  Future<List<SignatureStatus>> getSignatureStatuses(
      List<TxSignature> signatures,
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
}
