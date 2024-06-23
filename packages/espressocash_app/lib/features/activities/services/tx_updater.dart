import 'package:async/async.dart';
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

  Future<void> call({String? tokenAddress}) => _cache.fetch(
        () => tryEitherAsync((_) async {
          final String? mostRecentTxId = await _repo.mostRecentTxId();
          if (tokenAddress == null) {
            await _updateAllTokenAccounts(mostRecentTxId);
            await _updateSolTransactions(mostRecentTxId);
          } else {
            await _updateTokenTransactions(tokenAddress, mostRecentTxId);
          }
        }),
      );

  Future<void> _updateAllTokenAccounts(String? mostRecentTxId) async {
    final tokenAccounts = await getAllTokenAccounts(_wallet.publicKey);
    await Future.wait(
      tokenAccounts.map((account) async {
        final accountTokenAddress =
            await getMintAddressForTokenAccount(account);

        return _fetchAndSaveTransactions(
          account,
          accountTokenAddress,
          null,
          50,
        );
      }),
    );
  }

  Future<void> _updateSolTransactions(String? mostRecentTxId) async {
    await _fetchAndSaveTransactions(
      _wallet.publicKey,
      Token.sol.address,
      mostRecentTxId,
      20,
    );
  }

  Future<void> _updateTokenTransactions(
    String tokenAddress,
    String? mostRecentTxId,
  ) async {
    if (tokenAddress == Token.sol.address) {
      await _updateSolTransactions(mostRecentTxId);
    } else {
      final tokenAccount = await findAssociatedTokenAddress(
        owner: _wallet.publicKey,
        mint: Ed25519HDPublicKey.fromBase58(tokenAddress),
      );
      await _fetchAndSaveTransactions(
        tokenAccount,
        tokenAddress,
        null,
        50,
      );
    }
  }

  Future<void> _fetchAndSaveTransactions(
    Ed25519HDPublicKey account,
    String tokenAddress,
    String? until,
    int limit,
  ) async {
    Iterable<TransactionDetails> transactionDetails = [];
    try {
      transactionDetails = await _client.rpcClient.getTransactionsList(
        account,
        until: until,
        limit: limit,
        encoding: Encoding.base64,
        commitment: Commitment.confirmed,
      );
    } on Exception catch (_) {
      transactionDetails = [];
    }

    if (transactionDetails.isNotEmpty) {
      final txs =
          transactionDetails.map((it) => it.toFetched(account, tokenAddress));
      final hasGap = txs.length == limit;
      await _repo.saveAll(txs, clear: hasGap);
    }
  }

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

    Object? preTokenBalance;
    Object? postTokenBalance;
    int rawAmount;
    CryptoAmount? amount;

    if (tokenAddress == Token.sol.address) {
      preTokenBalance = meta?.preBalances;
      postTokenBalance = meta?.postBalances;
      if (preTokenBalance != null && postTokenBalance != null) {
        rawAmount = (postTokenBalance as List<int>)[accountIndex] -
            (preTokenBalance as List<int>)[accountIndex];

        amount = CryptoAmount(
          value: rawAmount,
          cryptoCurrency: const CryptoCurrency(token: Token.sol),
        );
      }
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
