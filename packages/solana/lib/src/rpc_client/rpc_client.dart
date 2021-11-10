import 'dart:async';

import 'package:solana/src/crypto/ed25519_hd_keypair.dart';
import 'package:solana/src/dto/account.dart';
import 'package:solana/src/dto/blockhash.dart';
import 'package:solana/src/dto/commitment.dart';
import 'package:solana/src/dto/signature_status.dart';
import 'package:solana/src/encoder/message.dart';
import 'package:solana/src/exceptions/transaction_exception.dart';
import 'package:solana/src/rpc_client/account_info_response.dart';
import 'package:solana/src/rpc_client/balance_response.dart';
import 'package:solana/src/rpc_client/blockhash_response.dart';
import 'package:solana/src/rpc_client/confirmed_signature.dart';
import 'package:solana/src/rpc_client/confirmed_transaction_response.dart';
import 'package:solana/src/rpc_client/get_transaction_response.dart';
import 'package:solana/src/rpc_client/json_rpc_client.dart';
import 'package:solana/src/rpc_client/minimum_balance_for_rent_exemption_response.dart';
import 'package:solana/src/rpc_client/simulate_tx_result.dart';
import 'package:solana/src/rpc_client/transaction_response.dart';
import 'package:solana/src/rpc_client/transaction_signature.dart';
import 'package:solana/src/spl_token/associated_account.dart';
import 'package:solana/src/spl_token/token_amount.dart';
import 'package:solana/src/spl_token/token_supply.dart';
import 'package:solana/src/utils.dart';

export 'confirmed_signature.dart' show ConfirmedSignature;
export 'transaction_response.dart';

part 'rpc_client_extensions.dart';

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

    // This is never `null`
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

    // Will never be null
    return BalanceResponse.fromJson(data).result.value;
  }

  /// Returns a Future that resolves to the account related information
  /// for [address].
  ///
  /// For [commitment] parameter description [see this document][see this document]
  /// [Commitment.processed] is not supported as [commitment].
  ///
  /// [see this document]: https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment
  Future<Account?> getAccountInfo(
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
  Future<TransactionSignature> sendTransaction(
      String encodedTransaction) async {
    final data = await client.request(
      'sendTransaction',
      params: <dynamic>[
        encodedTransaction,
        <String, String>{
          'encoding': 'base64',
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
    String transaction, {
    Commitment? commitment,
  }) async {
    final data = await client.request(
      'simulateTransaction',
      params: <dynamic>[
        transaction,
        <String, String>{
          'encoding': 'base64',
          if (commitment != null) 'commitment': commitment.value,
        }
      ],
    );

    // Will never be null
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

  /// Get minimum balance for rent exemption to allocate [size] bytes
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

  /// Get the balance of a token account with [associatedTokenAccountAddress].
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

  /// Gets associated token accounts for a given user. If [mint] or [programId]
  /// are provided, it returns the accounts associated to those specific values.
  ///
  /// For [commitment] parameter description [see this document][see this document]
  /// [Commitment.processed] is not supported as [commitment].
  ///
  /// [see this document]: https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment
  Future<Iterable<AssociatedTokenAccount>> getTokenAccountsByOwner({
    required String owner,
    String? mint,
    String? programId,
    Commitment? commitment,
  }) async {
    final data = await client.request(
      'getTokenAccountsByOwner',
      params: <dynamic>[
        owner,
        <String, String>{
          if (mint != null) 'mint': mint,
          if (programId != null) 'programId': programId,
        },
        <String, String>{
          'encoding': 'jsonParsed',
          if (commitment != null) 'commitment': commitment.value,
        }
      ],
    );

    // Will never be null
    return AssociatedTokenAccountResponse.fromJson(data).result.value;
  }
}
