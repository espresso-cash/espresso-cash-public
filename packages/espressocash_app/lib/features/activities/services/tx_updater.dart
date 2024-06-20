import 'package:async/async.dart';
import 'package:dfunc/dfunc.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/dto.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

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

  Future<void> call({
    String? tokenAddress,
  }) =>
      _cache.fetch(
        () => tryEitherAsync((_) async {
          final Ed25519HDPublicKey tokenAccount;
          String? mostRecentTxId;

          if (tokenAddress == Token.sol.address || tokenAddress == null) {
            tokenAccount = _wallet.publicKey;
            mostRecentTxId = await _repo.mostRecentTxId();
          } else {
            tokenAccount = await findAssociatedTokenAddress(
              owner: _wallet.publicKey,
              mint: Ed25519HDPublicKey.fromBase58(
                tokenAddress,
              ),
            );
          }

          const fetchLimit = 100;

          final details = await _client.rpcClient.getTransactionsList(
            tokenAccount,
            until: mostRecentTxId,
            limit: fetchLimit,
            encoding: Encoding.base64,
            commitment: Commitment.confirmed,
          );

          if (details.isNotEmpty) {
            final txs =
                details.map((it) => it.toFetched(tokenAccount, tokenAddress));

            final hasGap = mostRecentTxId != null && txs.length == fetchLimit;

            await _repo.saveAll(
              txs,
              clear: hasGap,
            );
          }
        }),
      );

  @override
  Future<void> onDispose() => _repo.clear();
}

extension on TransactionDetails {
  TxCommon toFetched(Ed25519HDPublicKey tokenAccount, String? tokenAddress) {
    final rawTx = transaction as RawTransaction;
    final tx = SignedTx.fromBytes(rawTx.data);

    final accountIndex =
        tx.compiledMessage.accountKeys.indexWhere((e) => e == tokenAccount);

    Object? preTokenBalance;
    Object? postTokenBalance;
    int rawAmount;
    CryptoAmount? amount;

    if (tokenAddress == Token.sol.address) {
      preTokenBalance = meta!.preBalances;
      postTokenBalance = meta!.postBalances;
      rawAmount = (postTokenBalance as List<int>)[0] -
          (preTokenBalance as List<int>)[0];

      amount = CryptoAmount(
        value: rawAmount,
        cryptoCurrency: const CryptoCurrency(token: Token.sol),
      );
    } else {
      preTokenBalance = meta?.preTokenBalances
          .where((e) => e.mint == tokenAddress)
          .where((e) => e.accountIndex == accountIndex)
          .firstOrNull;
      postTokenBalance = meta?.postTokenBalances
          .where((e) => e.mint == tokenAddress)
          .where((e) => e.accountIndex == accountIndex)
          .firstOrNull;
      final TokenList tokenList = GetIt.I<TokenList>();

      if (preTokenBalance != null && postTokenBalance != null) {
        rawAmount = int.parse(
              (postTokenBalance as TokenBalance).uiTokenAmount.amount,
            ) -
            int.parse((preTokenBalance as TokenBalance).uiTokenAmount.amount);

        amount = CryptoAmount(
          value: rawAmount,
          cryptoCurrency: CryptoCurrency(
            token:
                tokenList.findTokenByMint(tokenAddress ?? Token.usdc.address) ??
                    Token.usdc,
          ),
        );
      }
    }

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
