import 'package:async/async.dart';
import 'package:collection/collection.dart';
import 'package:dfunc/dfunc.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/base58.dart';
import 'package:solana/dto.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

import '../../../utils/chunks.dart';
import '../../accounts/auth_scope.dart';
import '../../accounts/models/ec_wallet.dart';
import '../../currency/models/amount.dart';
import '../../currency/models/currency.dart';
import '../../tokens/data/token_repository.dart';
import '../../tokens/token.dart';
import '../data/transaction_repository.dart';
import '../models/transaction.dart';

typedef TransactionUpdateResult = ({
  List<TxCommon> txs,
  bool hasGap,
});

@Singleton(scope: authScope)
class TxUpdater implements Disposable {
  TxUpdater(this._client, this._wallet, this._repo);

  final SolanaClient _client;
  final ECWallet _wallet;
  final TransactionRepository _repo;

  final AsyncCache<void> _cache = AsyncCache.ephemeral();

  @PostConstruct()
  void init() {
    call();
  }

  Future<void> call() => _cache.fetch(_updateAllTransactions);

  Future<void> _updateAllTransactions() async {
    final mostRecentTxId = await _repo.mostRecentTxId();

    final tokenResult = await _updateTokensTransactions(mostRecentTxId);
    final solResult = await _updateSolTransactions(mostRecentTxId);

    final uniqueSolTxs = solResult.txs
        .where(
          (result) => !tokenResult.txs.any((tx) => tx.tx.id == result.tx.id),
        )
        .toList();

    final allTxs = uniqueSolTxs + tokenResult.txs;

    if (allTxs.isNotEmpty) {
      await _repo.saveAll(
        allTxs,
        clear: solResult.hasGap || tokenResult.hasGap,
      );
    }
  }

  Future<TransactionUpdateResult> _updateTokensTransactions(
    String? mostRecentTxId,
  ) async {
    final tokenAccounts = await _getAllTokenAccounts(_wallet.publicKey);
    final allResults = <TransactionUpdateResult>[];

    final batches = tokenAccounts.chunks(5).toList();
    for (int i = 0; i < batches.length; i++) {
      final batch = batches[i];
      final batchResults = await Future.wait<TransactionUpdateResult>(
        batch.map((account) async {
          final limit = account.mintAddress == Token.usdc.address
              ? _usdcFetchLimit
              : _tokenFetchLimit;

          final txs = await _fetchTransactions(
            account.account,
            account.mintAddress,
            mostRecentTxId,
            limit,
          );

          return (
            txs: txs,
            hasGap: mostRecentTxId != null && txs.length == limit,
          );
        }),
      );

      allResults.addAll(batchResults);

      if (i < batches.length - 1) {
        await Future<void>.delayed(const Duration(milliseconds: 500));
      }
    }

    return (
      txs: allResults.expand((r) => r.txs).toList(),
      hasGap: allResults.any((r) => r.hasGap),
    );
  }

  Future<TransactionUpdateResult> _updateSolTransactions(
    String? mostRecentTxId,
  ) async {
    final txs = await _fetchTransactions(
      _wallet.publicKey,
      Token.sol.address,
      mostRecentTxId,
      _tokenFetchLimit,
    );

    return (
      txs: txs,
      hasGap: mostRecentTxId != null && txs.length == _tokenFetchLimit,
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

  Future<List<_TokenAccountInfo>> _getAllTokenAccounts(
    Ed25519HDPublicKey owner,
  ) =>
      _client.rpcClient
          .getTokenAccountsByOwner(
            owner.toBase58(),
            encoding: Encoding.base64,
            const TokenAccountsFilter.byProgramId(TokenProgram.programId),
          )
          .letAsync(
            (response) => response.value.map((account) {
              final data = account.account.data as BinaryAccountData?;
              if (data == null) {
                throw Exception('Account info or data is null');
              }
              final mintAddressBytes = data.data.sublist(0, 32);
              final mintAddress = base58encode(mintAddressBytes);

              return _TokenAccountInfo(
                account: Ed25519HDPublicKey.fromBase58(account.pubkey),
                mintAddress: mintAddress,
              );
            }).toList(),
          );

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

class _TokenAccountInfo {
  const _TokenAccountInfo({
    required this.account,
    required this.mintAddress,
  });

  final Ed25519HDPublicKey account;
  final String mintAddress;
}

const _tokenFetchLimit = 15;
const _usdcFetchLimit = 50;
