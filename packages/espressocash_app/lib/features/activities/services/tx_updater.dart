import 'dart:async';

import 'package:async/async.dart';
import 'package:collection/collection.dart';
import 'package:dfunc/dfunc.dart';
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
import '../../tokens/token.dart';
import '../../tokens/token_list.dart';
import '../data/transaction_repository.dart';
import '../models/transaction.dart';

@Singleton(scope: authScope)
class TxUpdater implements Disposable {
  TxUpdater(this._client, this._wallet, this._repo);

  final SolanaClient _client;
  final ECWallet _wallet;
  final TransactionRepository _repo;

  final AsyncCache<void> _cache = AsyncCache.ephemeral();

  Future<void> call({String? tokenAddress}) => _cache.fetchEither(() async {
        if (tokenAddress == null) {
          await _updateAllTokenTransactions();
          await _updateSolTransactions();
        } else {
          await _updateTokenTransactions(tokenAddress);
        }
      });

  Future<void> _updateAllTokenTransactions() =>
      getAllTokenAccounts(_wallet.publicKey).letAsync(
        (tokenAccounts) async => Future.wait(
          tokenAccounts.map((account) async {
            await getMintAddressForTokenAccount(account).letAsync(
              (tokenAccountAddress) => _fetchAndSaveTransactions(
                account,
                tokenAccountAddress,
                null,
                50,
              ),
            );
          }),
        ),
      );

  Future<void> _updateSolTransactions() => _fetchAndSaveTransactions(
        _wallet.publicKey,
        Token.sol.address,
        null,
        20,
      );

  Future<void> _updateTokenTransactions(
    String tokenAddress,
  ) async {
    tokenAddress.let((t) => t == Token.sol.address)
        ? await _updateSolTransactions()
        : await findAssociatedTokenAddress(
            owner: _wallet.publicKey,
            mint: Ed25519HDPublicKey.fromBase58(tokenAddress),
          ).letAsync(
            (tokenAccount) async => _fetchAndSaveTransactions(
              tokenAccount,
              tokenAddress,
              null,
              50,
            ),
          );
  }

  Future<void> _fetchAndSaveTransactions(
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
        if (transactionDetails.isEmpty) return;

        final txs =
            transactionDetails.map((it) => it.toFetched(account, tokenAddress));

        await _repo.saveAll(txs, clear: false);
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
  TxCommon toFetched(Ed25519HDPublicKey tokenAccount, String? tokenAddress) {
    final rawTx = transaction as RawTransaction;
    final tx = SignedTx.fromBytes(rawTx.data);
    final accountIndex =
        tx.compiledMessage.accountKeys.indexWhere((e) => e == tokenAccount);

    int? getBalanceDifference(
      List<Object>? preBalances,
      List<Object>? postBalances,
    ) =>
        (preBalances != null && postBalances != null)
            ? (postBalances[accountIndex] as int) -
                (preBalances[accountIndex] as int)
            : null;

    int? getTokenBalanceDifference(
      List<TokenBalance>? preBalances,
      List<TokenBalance>? postBalances,
    ) =>
        preBalances
            ?.firstWhereOrNull(
              (e) => e.mint == tokenAddress && e.accountIndex == accountIndex,
            )
            ?.let(
              (preBalance) => postBalances
                  ?.firstWhereOrNull(
                    (e) =>
                        e.mint == tokenAddress &&
                        e.accountIndex == accountIndex,
                  )
                  ?.let(
                    (postBalance) =>
                        int.parse(postBalance.uiTokenAmount.amount) -
                        int.parse(preBalance.uiTokenAmount.amount),
                  ),
            );

    final rawAmount = tokenAddress == Token.sol.address
        ? getBalanceDifference(meta?.preBalances, meta?.postBalances)
        : getTokenBalanceDifference(
            meta?.preTokenBalances,
            meta?.postTokenBalances,
          );

    final amount = rawAmount?.let((amount) {
      final tokenList = GetIt.I<TokenList>();
      final cryptoCurrency = tokenAddress == Token.sol.address
          ? const CryptoCurrency(token: Token.sol)
          : CryptoCurrency(
              token: tokenList
                      .findTokenByMint(tokenAddress ?? Token.usdc.address) ??
                  Token.usdc,
            );

      return CryptoAmount(value: amount, cryptoCurrency: cryptoCurrency);
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
