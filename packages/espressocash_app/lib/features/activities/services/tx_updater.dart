import 'dart:async';

import 'package:async/async.dart';
import 'package:collection/collection.dart';
import 'package:dfunc/dfunc.dart';
import 'package:drift/drift.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/base58.dart';
import 'package:solana/dto.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

import '../../../utils/async_cache.dart';
import '../../accounts/auth_scope.dart';
import '../../accounts/models/ec_wallet.dart';
import '../../currency/models/amount.dart';
import '../../currency/models/currency.dart';
import '../../tokens/data/token_repository.dart';
import '../../tokens/token.dart';
import '../data/transaction_repository.dart';
import '../models/transaction.dart';

@Singleton(scope: authScope)
class TxUpdater implements Disposable {
  TxUpdater(this._client, this._wallet, this._repo);

  final SolanaClient _client;
  final ECWallet _wallet;
  final TransactionRepository _repo;

  final AsyncCache<void> _callCache = AsyncCache.ephemeral();

  Future<void> call({String? tokenAddress}) => _callCache.fetchEither(() async {
        final String? mostRecentTxId = await _repo.mostRecentTxId();

        if (tokenAddress == null) {
          final allTokensTx = await _updateAllTokenTransactions(mostRecentTxId);

          await _updateSolTransactions(mostRecentTxId: mostRecentTxId).letAsync(
            (results) async {
              final uniqueResults = results
                  .where(
                    (result) => !allTokensTx.any(
                      (tx) => tx.tx.id == result.tx.id,
                    ),
                  )
                  .toList();

              await _repo.saveAll(
                (allTokensTx + uniqueResults).toSet().toList(),
                clear: false,
              );
            },
          );
        } else {
          await _updateTokenTransactions(
            tokenAddress,
            mostRecentTxId: mostRecentTxId,
          );
        }
      });

  Future<List<TxCommon>> _updateAllTokenTransactions(String? mostRecentTxId) =>
      getAllTokenAccounts(_wallet.publicKey).letAsync(
        (tokenAccounts) async {
          final transactions = await Future.wait(
            tokenAccounts.map(
              (account) async =>
                  getMintAddressForTokenAccount(account).letAsync(
                (tokenAccountAddress) => _fetchTransactions(
                  account,
                  tokenAccountAddress,
                  mostRecentTxId,
                  25,
                ),
              ),
            ),
          );

          return transactions.expand((txs) => txs).toList();
        },
      );

  Future<List<TxCommon>> _updateSolTransactions({String? mostRecentTxId}) =>
      _fetchTransactions(
        _wallet.publicKey,
        Token.sol.address,
        mostRecentTxId,
        25,
      );

  Future<void> _updateTokenTransactions(
    String tokenAddress, {
    String? mostRecentTxId,
  }) async {
    tokenAddress.let((t) => t == Token.sol.address)
        ? await _updateSolTransactions(mostRecentTxId: mostRecentTxId).letAsync(
            (txs) async => _repo.saveAll(
              txs,
              clear: false,
              mode: InsertMode.insertOrIgnore,
            ),
          )
        : await findAssociatedTokenAddress(
            owner: _wallet.publicKey,
            mint: Ed25519HDPublicKey.fromBase58(tokenAddress),
          ).letAsync(
            (tokenAccount) => _fetchTransactions(
              tokenAccount,
              tokenAddress,
              mostRecentTxId,
              25,
            ).letAsync(
              (txs) => _repo.saveAll(txs, clear: false),
            ),
          );
  }

  Future<List<TxCommon>> _fetchTransactions(
    Ed25519HDPublicKey account,
    String tokenAddress,
    String? until,
    int limit,
  ) =>
      _client.rpcClient
          .getTransactionsList(
        account,
        until: until,
        limit: limit,
        encoding: Encoding.base64,
        commitment: Commitment.confirmed,
      )
          .letAsync((transactionDetails) async {
        if (transactionDetails.isEmpty) return [];

        final txs = await Future.wait(
          transactionDetails.map((it) => it.toFetched(account, tokenAddress)),
        );
        final filteredTxs = txs.whereNotNull().toList();

        return filteredTxs.toSet().toList();
      });

  Future<List<Ed25519HDPublicKey>> getAllTokenAccounts(
    Ed25519HDPublicKey owner,
  ) async {
    final accounts = await _client.rpcClient.getTokenAccountsByOwner(
      owner.toBase58(),
      encoding: Encoding.base64,
      const TokenAccountsFilter.byProgramId(TokenProgram.programId),
    );

    return accounts.value
        .map((account) => Ed25519HDPublicKey.fromBase58(account.pubkey))
        .toList();
  }

  Future<String> getMintAddressForTokenAccount(
    Ed25519HDPublicKey tokenAccount,
  ) async {
    final accountInfo = await _client.rpcClient.getAccountInfo(
      tokenAccount.toBase58(),
      encoding: Encoding.base64,
    );

    final accountData = accountInfo.value?.data;
    if (accountData == null) {
      throw Exception('Account info or data is null');
    }

    final data = accountData as BinaryAccountData;
    final mintAddressBytes = data.data.sublist(0, 32);

    return Ed25519HDPublicKey.fromBase58(base58encode(mintAddressBytes))
        .toBase58();
  }

  @override
  Future<void> onDispose() => _repo.clear();
}

extension on TransactionDetails {
  Future<TxCommon?> toFetched(
    Ed25519HDPublicKey tokenAccount,
    String? tokenAddress,
  ) async {
    final rawTx = transaction as RawTransaction;
    final tx = SignedTx.fromBytes(rawTx.data);
    final accountIndex =
        tx.compiledMessage.accountKeys.indexWhere((e) => e == tokenAccount);

    int? getBalanceDifference(
      List<Object>? preBalances,
      List<Object>? postBalances,
    ) {
      if (preBalances != null && postBalances != null) {
        final preBalance = preBalances[accountIndex] as int;
        final postBalance = postBalances[accountIndex] as int;
        if (preBalance == 0 && postBalance == 0) return null;

        return postBalance - preBalance;
      }

      return null;
    }

    int? getTokenBalanceDifference(
      List<TokenBalance>? preBalances,
      List<TokenBalance>? postBalances,
    ) {
      final preBalance = preBalances
          ?.firstWhereOrNull(
            (e) => e.mint == tokenAddress && e.accountIndex == accountIndex,
          )
          ?.uiTokenAmount
          .amount;

      final postBalance = postBalances
          ?.firstWhereOrNull(
            (e) => e.mint == tokenAddress && e.accountIndex == accountIndex,
          )
          ?.uiTokenAmount
          .amount;

      final preReturnValue = preBalance != null ? int.parse(preBalance) : 0;
      final postReturnValue = postBalance != null ? int.parse(postBalance) : 0;

      if (preReturnValue == 0 && postReturnValue == 0) return null;

      return postReturnValue - preReturnValue;
    }

    final rawAmount = tokenAddress == Token.sol.address
        ? getBalanceDifference(meta?.preBalances, meta?.postBalances)
        : getTokenBalanceDifference(
            meta?.preTokenBalances,
            meta?.postTokenBalances,
          );

    if (rawAmount == null || rawAmount == 0) return null;

    final amount = await rawAmount.let((amount) async {
      final tokenRepository = GetIt.I<TokenRepository>();
      final cryptoCurrency = tokenAddress != null
          ? tokenAddress == Token.sol.address
              ? const CryptoCurrency(token: Token.sol)
              : CryptoCurrency(
                  token:
                      await tokenRepository.getToken(tokenAddress) ?? Token.unk,
                )
          : const CryptoCurrency(token: Token.unk);

      return CryptoAmount(
        value: amount,
        cryptoCurrency: cryptoCurrency,
      );
    });

    return TxCommon(
      tx,
      status:
          meta?.err == null ? TxCommonStatus.success : TxCommonStatus.failure,
      created: blockTime
          ?.let((it) => DateTime.fromMillisecondsSinceEpoch(1000 * it)),
      amount: amount,
    );
  }
}
