import 'package:solana/solana.dart';
import 'package:solana/src/rpc/rpc.dart';

class SolanaClient {
  SolanaClient({required Uri rpcUrl, required Uri websocketUrl})
      : _rpcClient = RpcClient(rpcUrl.toString()),
        _websocketUrl = websocketUrl;

  final RpcClient _rpcClient;
  final Uri _websocketUrl;

  /// Creates a solana transfer message to send [lamports] SOL tokens from [source]
  /// to [destination].
  ///
  /// To add additional data to the transaction you can use the [memo] field.
  /// It accepts an arbitrary string of utf-8 characters. As of now the maximum
  /// allowed length for the memo is 566 bytes of utf-8 data.
  ///
  /// NOTE: This constructor creates a transaction with 2 instructions when a [memo]
  /// is provided.
  ///
  /// For [commitment] parameter description [see this document][1]
  /// [Commitment.processed] is not supported as [commitment].
  ///
  /// [1]: https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment
  Future<String> transferLamports({
    required Wallet source,
    required String destination,
    required int lamports,
    String? memo,
    Commitment commitment = Commitment.finalized,
  }) =>
      _genericTransfer(
        source: source.address,
        signer: source,
        destination: destination,
        lamports: lamports,
        memo: memo,
        commitment: commitment,
      );

  /// Request airdrop for [amount] to this wallet's account.
  ///
  /// For [commitment] parameter description [see this document][1]
  /// [Commitment.processed] is not supported as [commitment].
  ///
  /// [1]: https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment
  Future<String> requestAirdrop({
    required String address,
    required int lamports,
    Commitment commitment = Commitment.finalized,
  }) async {
    final signature = await _rpcClient.requestAirdrop(
      address,
      lamports,
      commitment: commitment,
    );
    await _createSubscriptionClient().waitForSignatureStatus(
      signature,
      status: commitment,
    );

    return signature;
  }

  /// Transfers [amount] SPL token with [mint] from this wallet to the
  /// [destination] address with an optional [memo].
  ///
  /// For [commitment] parameter description [see this document][1]
  /// [Commitment.processed] is not supported as [commitment].
  ///
  /// [1]: https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment
  Future<String> transferSplToken({
    required Wallet source,
    required String mint,
    required String destination,
    required int amount,
    String? memo,
    Commitment commitment = Commitment.finalized,
  }) async {
    final token = await SplToken.readonly(
      mint: mint,
      rpcClient: _rpcClient,
    );

    return token.transfer(
      source: source.address,
      amount: amount,
      destination: destination,
      owner: source,
      commitment: commitment,
      memo: memo,
      rpcClient: _rpcClient,
      subscriptionClient: _createSubscriptionClient(),
    );
  }

  /// Create the account associated to the SPL token [mint] for this wallet.
  ///
  /// If you want to use another wallet as a funder use the [funder] parameter.
  ///
  /// Also adds the token to the wallet object.
  ///
  /// For [commitment] parameter description [see this document][1]
  /// [Commitment.processed] is not supported as [commitment].
  ///
  /// [1]: https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment
  Future<ProgramAccount> createAssociatedTokenAccount({
    required Wallet owner,
    required String mint,
    Commitment? commitment,
    Wallet? funder,
  }) async {
    final token = await SplToken.readonly(mint: mint, rpcClient: _rpcClient);
    final associatedTokenAccount = await token.createAssociatedAccount(
      owner: owner.address,
      funder: funder ?? owner,
      rpcClient: _rpcClient,
      subscriptionClient: _createSubscriptionClient(),
    );

    return associatedTokenAccount;
  }

  /// Whether this wallet has an associated token account for the SPL token [mint].
  Future<bool> hasAssociatedTokenAccount({
    required String owner,
    required String mint,
  }) async {
    Iterable<ProgramAccount> accounts;
    final token = await SplToken.readonly(
      mint: mint,
      rpcClient: _rpcClient,
    );
    final associatedTokenAddress = await token.computeAssociatedAddress(
      owner: owner,
    );
    try {
      accounts = await _rpcClient.getTokenAccountsByOwner(
        owner,
        TokenAccountsFilter.byMint(token.mint),
        encoding: Encoding.jsonParsed,
      );
    } on FormatException {
      accounts = [];
    }
    return accounts.any((a) => a.pubkey == associatedTokenAddress);
  }

  /// Get the account associated to the SPL token [mint] for this wallet.
  ///
  /// Note: this method always returns the address because it is computed
  /// when the [Wallet.loadToken()] method is called
  Future<String> getProgramAccountAddress({
    required String owner,
    required String mint,
  }) async {
    final token = await SplToken.readonly(mint: mint, rpcClient: _rpcClient);
    return token.computeAssociatedAddress(owner: owner);
  }

  /// Get token [mint] balance for this wallet's account.
  ///
  /// For [commitment] parameter description [see this document][1]
  /// [Commitment.processed] is not supported as [commitment].
  ///
  /// [1]: https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment
  Future<TokenAmount> getTokenBalance({
    required String owner,
    required String mint,
    Commitment? commitment,
  }) async =>
      _rpcClient.getTokenAccountBalance(
        await getProgramAccountAddress(owner: owner, mint: mint),
        commitment: commitment,
      );

  /// Get the balance in lamports for this wallet's account
  ///
  /// For [commitment] parameter description [see this document][1]
  /// [Commitment.processed] is not supported as [commitment].
  ///
  /// [1]: https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment
  Future<int> getLamports({
    required String address,
    Commitment? commitment,
  }) =>
      _rpcClient.getBalance(address, commitment: commitment);

  SubscriptionClient _createSubscriptionClient() =>
      SubscriptionClient(_websocketUrl);

  Future<String> _genericTransfer({
    required String source,
    required String destination,
    required int lamports,
    required Commitment commitment,
    required Wallet signer,
    String? memo,
  }) async {
    final instructions = [
      SystemInstruction.transfer(
        source: source,
        destination: destination,
        lamports: lamports,
      ),
      if (memo != null) MemoInstruction(signers: [source], memo: memo),
    ];

    final message = Message(
      instructions: instructions,
    );

    final signature = await _rpcClient.signAndSendTransaction(
      message,
      [signer],
    );
    await _createSubscriptionClient().waitForSignatureStatus(
      signature,
      status: commitment,
    );

    return signature;
  }
}
