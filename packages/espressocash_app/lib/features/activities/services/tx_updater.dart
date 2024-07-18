part of '../data/transaction_repository.dart';

extension TxUpdater on TransactionRepository {
  Future<void> update({String? tokenAddress}) => _callCache.fetchEither(
        () => mostRecentTxId().letAsync(
          (mostRecentTxId) async => tokenAddress == null
              ? await _updateAllTokenTransactions(mostRecentTxId).letAsync(
                  (allTokensTxs) =>
                      _updateSolTransactions(mostRecentTxId: mostRecentTxId)
                          .letAsync(
                    (allSolTxs) => saveAll(
                      allTokensTxs +
                          allSolTxs
                              .where(
                                (result) => !allTokensTxs.any(
                                  (tx) => tx.tx.id == result.tx.id,
                                ),
                              )
                              .toList(),
                    ),
                  ),
                )
              : await _updateTokenTransactions(
                  tokenAddress,
                  mostRecentTxId: mostRecentTxId,
                ),
        ),
      );

  Future<List<TxCommon>> _updateAllTokenTransactions(String? mostRecentTxId) =>
      _getAllTokenAccounts(_wallet.publicKey).letAsync(
        (tokenAccounts) async => (await Future.wait(
          tokenAccounts.map(
            (account) => getMintAddressForTokenAccount(account).letAsync(
              (tokenAccountAddress) => _fetchTransactions(
                account,
                tokenAccountAddress,
                mostRecentTxId,
                15,
              ),
            ),
          ),
        ))
            .expand((txs) => txs)
            .toList(),
      );

  Future<List<TxCommon>> _updateSolTransactions({String? mostRecentTxId}) =>
      _fetchTransactions(
        _wallet.publicKey,
        Token.sol.address,
        mostRecentTxId,
        15,
      );

  Future<void> _updateTokenTransactions(
    String tokenAddress, {
    String? mostRecentTxId,
  }) async =>
      tokenAddress.let((t) => t == Token.sol.address)
          ? await _updateSolTransactions(mostRecentTxId: mostRecentTxId)
              .letAsync(
              (txs) async => saveAll(
                txs,
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
                15,
              ).letAsync(
                saveAll,
              ),
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

  Future<List<Ed25519HDPublicKey>> _getAllTokenAccounts(
    Ed25519HDPublicKey owner,
  ) =>
      _client.rpcClient
          .getTokenAccountsByOwner(
            owner.toBase58(),
            encoding: Encoding.base64,
            const TokenAccountsFilter.byProgramId(TokenProgram.programId),
          )
          .letAsync(
            (accounts) => accounts.value
                .map((account) => Ed25519HDPublicKey.fromBase58(account.pubkey))
                .toList(),
          );

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
