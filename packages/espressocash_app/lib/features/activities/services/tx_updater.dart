import 'package:async/async.dart';
import 'package:collection/collection.dart';
import 'package:dfunc/dfunc.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/base58.dart';
import 'package:solana/dto.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

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

  @PostConstruct()
  void init() {
    call();
  }

  Future<void> call() => _callCache.fetch(_updateAllTransactions);

  Future<void> _updateAllTransactions() async {
    final mostRecentTxId = await _repo.mostRecentTxId();
    final tokenTxs = await _updateTokensTransactions(mostRecentTxId);
    final solTxs = await _updateSolTransactions(mostRecentTxId: mostRecentTxId);

    final uniqueSolTxs = solTxs
        .where(
          (result) => !tokenTxs.any((tx) => tx.tx.id == result.tx.id),
        )
        .toList();

    await _repo.saveAll(tokenTxs + uniqueSolTxs);
  }

  Future<List<TxCommon>> _updateTokensTransactions(
    String? mostRecentTxId,
  ) async {
    final tokenAccounts = await _getAllTokenAccounts(_wallet.publicKey);

    final allTransactions = await Future.wait(
      tokenAccounts.map(
        (account) => _fetchTransactions(
          account.account,
          account.mintAddress,
          mostRecentTxId,
          15,
        ),
      ),
    );

    return allTransactions.expand((txs) => txs).toList();
  }

  Future<List<TxCommon>> _updateSolTransactions({String? mostRecentTxId}) =>
      _fetchTransactions(
        _wallet.publicKey,
        Token.sol.address,
        mostRecentTxId,
        15,
      );

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

  Future<List<TokenAccountInfo>> _getAllTokenAccounts(
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

              return TokenAccountInfo(
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

class TokenAccountInfo {
  const TokenAccountInfo({
    required this.account,
    required this.mintAddress,
  });

  final Ed25519HDPublicKey account;
  final String mintAddress;
}
