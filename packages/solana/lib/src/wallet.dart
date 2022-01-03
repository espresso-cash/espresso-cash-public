import 'package:solana/src/crypto/ed25519_hd_keypair.dart';
import 'package:solana/src/encoder/message.dart';
import 'package:solana/src/programs/memo_program/memo_instruction.dart';
import 'package:solana/src/programs/system_program/system_instruction.dart';
import 'package:solana/src/rpc/client.dart';
import 'package:solana/src/rpc/dto/dto.dart';
import 'package:solana/src/spl_token/spl_token.dart';
import 'package:solana/src/subscription_client/subscription_client.dart';

typedef Wallet = Ed25519HDKeyPair;

extension WalletExt on Wallet {
  Future<String> _genericTransfer({
    required RpcClient rpcClient,
    required SubscriptionClient subscriptionClient,
    required String source,
    required String destination,
    required int lamports,
    required Commitment commitment,
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

    final signature = await rpcClient.signAndSendTransaction(
      message,
      [this],
    );
    await subscriptionClient.waitForSignatureStatus(
      signature,
      status: commitment,
    );

    return signature;
  }

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
  /// For [commitment] parameter description [see this document][see this document]
  /// [Commitment.processed] is not supported as [commitment].
  ///
  /// [see this document]: https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment
  Future<String> transfer({
    required RpcClient rpcClient,
    required SubscriptionClient subscriptionClient,
    required String destination,
    required int lamports,
    String? memo,
    Commitment commitment = Commitment.finalized,
  }) =>
      _genericTransfer(
        rpcClient: rpcClient,
        subscriptionClient: subscriptionClient,
        source: address,
        destination: destination,
        lamports: lamports,
        memo: memo,
        commitment: commitment,
      );

  /// Request airdrop for [amount] to this wallet's account.
  ///
  /// For [commitment] parameter description [see this document][see this document]
  /// [Commitment.processed] is not supported as [commitment].
  ///
  /// [see this document]: https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment
  Future<String> requestAirdrop({
    required RpcClient rpcClient,
    required SubscriptionClient subscriptionClient,
    required int lamports,
    Commitment commitment = Commitment.finalized,
  }) async {
    final signature = await rpcClient.requestAirdrop(
      address,
      lamports,
      commitment: commitment,
    );
    await subscriptionClient.waitForSignatureStatus(
      signature,
      status: commitment,
    );

    return signature;
  }

  /// Transfers [amount] SPL token with [mint] from this wallet to the
  /// [destination] address with an optional [memo].
  ///
  /// For [commitment] parameter description [see this document][see this document]
  /// [Commitment.processed] is not supported as [commitment].
  ///
  /// [see this document]: https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment
  Future<String> transferSplToken({
    required RpcClient rpcClient,
    required SubscriptionClient subscriptionClient,
    required String mint,
    required String destination,
    required int amount,
    String? memo,
    Commitment commitment = Commitment.finalized,
  }) async {
    final token = await SplToken.readonly(
      mint: mint,
      rpcClient: rpcClient,
    );

    return token.transfer(
      source: address,
      amount: amount,
      destination: destination,
      owner: this,
      commitment: commitment,
      memo: memo,
      rpcClient: rpcClient,
      subscriptionClient: subscriptionClient,
    );
  }

  /// Create the account associated to the SPL token [mint] for this wallet.
  ///
  /// If you want to use another wallet as a funder use the [funder] parameter.
  ///
  /// Also adds the token to the wallet object.
  ///
  /// For [commitment] parameter description [see this document][see this document]
  /// [Commitment.processed] is not supported as [commitment].
  ///
  /// [see this document]: https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment
  Future<ProgramAccount> createAssociatedTokenAccount({
    required RpcClient rpcClient,
    required SubscriptionClient subscriptionClient,
    required String mint,
    Commitment? commitment,
    Wallet? funder,
  }) async {
    final token = await SplToken.readonly(mint: mint, rpcClient: rpcClient);
    final associatedTokenAccount = await token.createAssociatedAccount(
      owner: address,
      funder: funder ?? this,
      rpcClient: rpcClient,
      subscriptionClient: subscriptionClient,
    );

    return associatedTokenAccount;
  }

  /// Whether this wallet has an associated token account for the SPL token [mint].
  Future<bool> hasAssociatedTokenAccount({
    required RpcClient rpcClient,
    required String mint,
  }) async {
    Iterable<ProgramAccount> accounts;
    final token = await SplToken.readonly(
      mint: mint,
      rpcClient: rpcClient,
    );
    final associatedTokenAddress = await token.computeAssociatedAddress(
      owner: address,
    );
    try {
      accounts = await rpcClient.getTokenAccountsByOwner(
        address,
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
    required RpcClient rpcClient,
    required String mint,
  }) async {
    final token = await SplToken.readonly(mint: mint, rpcClient: rpcClient);
    return token.computeAssociatedAddress(owner: address);
  }

  /// Get token [mint] balance for this wallet's account.
  ///
  /// For [commitment] parameter description [see this document][see this document]
  /// [Commitment.processed] is not supported as [commitment].
  ///
  /// [see this document]: https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment
  Future<TokenAmount> getTokenBalance({
    required RpcClient rpcClient,
    required String mint,
    Commitment? commitment,
  }) async =>
      rpcClient.getTokenAccountBalance(
        await getProgramAccountAddress(rpcClient: rpcClient, mint: mint),
        commitment: commitment,
      );

  /// Get the balance in lamports for this wallet's account
  ///
  /// For [commitment] parameter description [see this document][see this document]
  /// [Commitment.processed] is not supported as [commitment].
  ///
  /// [see this document]: https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment
  Future<int> getLamports({
    required RpcClient rpcClient,
    Commitment? commitment,
  }) =>
      rpcClient.getBalance(address, commitment: commitment);
}
