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
import '../data/transaction_repository.dart';
import '../models/transaction.dart';

@Singleton(scope: authScope)
class TxUpdater implements Disposable {
  TxUpdater(this._client, this._wallet, this._repo);

  final SolanaClient _client;
  final ECWallet _wallet;
  final TransactionRepository _repo;

  final AsyncCache<void> _cache = AsyncCache.ephemeral();

  Future<void> call() => _cache.fetch(
        () => tryEitherAsync((_) async {
          final usdcTokenAccount = await findAssociatedTokenAddress(
            owner: _wallet.publicKey,
            mint: Ed25519HDPublicKey.fromBase58(Token.usdc.address),
          );

          final mostRecentTxId = await _repo.mostRecentTxId();

          const fetchLimit = 50;

          final details = await _client.rpcClient.getTransactionsList(
            usdcTokenAccount,
            limit: fetchLimit,
            until: mostRecentTxId,
            encoding: Encoding.base64,
            commitment: Commitment.confirmed,
          );

          if (details.isNotEmpty) {
            final txs = details.map((it) => it.toFetched(usdcTokenAccount));

            final hasGap = mostRecentTxId != null && txs.length == fetchLimit;

            await _repo.saveAll(txs, clear: hasGap);
          }
        }),
      );

  @override
  Future<void> onDispose() => _repo.clear();
}

extension on TransactionDetails {
  TxCommon toFetched(Ed25519HDPublicKey usdcTokenAddress) {
    final rawTx = transaction as RawTransaction;
    final tx = SignedTx.fromBytes(rawTx.data);

    final accountIndex =
        tx.compiledMessage.accountKeys.indexWhere((e) => e == usdcTokenAddress);

    final preTokenBalance = meta?.preTokenBalances
        .where((e) => e.mint == Token.usdc.address)
        .where((e) => e.accountIndex == accountIndex)
        .firstOrNull;

    final postTokenBalance = meta?.postTokenBalances
        .where((e) => e.mint == Token.usdc.address)
        .where((e) => e.accountIndex == accountIndex)
        .firstOrNull;

    CryptoAmount? amount;

    if (preTokenBalance != null && postTokenBalance != null) {
      final rawAmount = int.parse(postTokenBalance.uiTokenAmount.amount) -
          int.parse(preTokenBalance.uiTokenAmount.amount);

      amount = CryptoAmount(
        value: rawAmount,
        cryptoCurrency: Currency.usdc,
      );
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
