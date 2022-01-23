import 'dart:async';

import 'package:solana/solana.dart';
import 'package:solana/src/encoder/signature.dart';
import 'package:solana/src/rpc/rpc.dart';

class SolanaClient {
  SolanaClient({
    required Uri rpcUrl,
    required Uri websocketUrl,
    Duration timeout = const Duration(seconds: 30),
  })  : rpcClient = RpcClient(rpcUrl.toString(), timeout: timeout),
        _timeout = timeout,
        _websocketUrl = websocketUrl;

  final RpcClient rpcClient;
  final Uri _websocketUrl;
  final Duration _timeout;

  /// Waits for transation with [signature] to reach [status].
  /// Throws exception if transaction failed.
  ///
  /// If [timeout] is null then timeout from [SolanaClient] is used.
  Future<void> waitForSignatureStatus(
    String signature, {
    required ConfirmationStatus status,
    Duration? timeout,
  }) async =>
      _createSubscriptionClient().waitForSignatureStatus(
        signature,
        status: status,
        timeout: timeout ?? _timeout,
      );

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
    FutureOr<void> Function(Signature)? onSigned,
    Commitment commitment = Commitment.finalized,
  }) async {
    final instructions = [
      SystemInstruction.transfer(
        source: source.address,
        destination: destination,
        lamports: lamports,
      ),
      if (memo != null) MemoInstruction(signers: [source.address], memo: memo),
    ];

    final message = Message(
      instructions: instructions,
    );

    final signature = await rpcClient.signAndSendTransaction(
      message,
      [source],
      onSigned: onSigned,
    );
    await waitForSignatureStatus(
      signature,
      status: commitment,
    );

    return signature;
  }

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
    final signature = await rpcClient.requestAirdrop(
      address,
      lamports,
      commitment: commitment,
    );
    await waitForSignatureStatus(
      signature,
      status: commitment,
    );

    return signature;
  }

  /// Create a new token owned by [owner] with [decimals] base 10 decimal digits.
  ///
  /// You can optionally specify a [mintAuthority] address. By default the [owner]
  /// address will be used as the _Mint Authority_.
  ///
  /// Also optional, you can specify a [freezeAuthority]. By default the
  /// [freezeAuthority] is not set.
  ///
  /// Finally, you can also send the transaction with optional [commitment].
  Future<SplToken> initializeMint({
    required Wallet owner,
    required int decimals,
    String? mintAuthority,
    String? freezeAuthority,
    Commitment commitment = Commitment.finalized,
  }) async {
    const space = TokenProgram.neededMintAccountSpace;
    final mintWallet = await Ed25519HDKeyPair.random();
    final rent = await rpcClient.getMinimumBalanceForRentExemption(space);

    final message = TokenProgram.initializeMint(
      mint: mintWallet.address,
      mintAuthority: mintAuthority ?? owner.address,
      freezeAuthority: freezeAuthority,
      rent: rent,
      space: space,
      decimals: decimals,
    );
    final signature = await rpcClient.signAndSendTransaction(
      message,
      [owner, mintWallet],
    );
    await waitForSignatureStatus(
      signature,
      status: commitment,
    );

    return createReadWriteToken(owner: owner, mint: mintWallet.address);
  }

  /// Mint [destination] with [amount] tokens. Requires writable [Token].
  Future<void> transferMint({
    required String destination,
    required int amount,
    required String mint,
    required Wallet owner,
    Commitment commitment = Commitment.finalized,
  }) async {
    final message = TokenProgram.mintTo(
      mint: mint,
      destination: destination,
      authority: owner.address,
      amount: amount,
    );
    final signature = await rpcClient.signAndSendTransaction(
      message,
      [owner],
    );
    await waitForSignatureStatus(
      signature,
      status: commitment,
    );
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
    final associatedRecipientAccount = await getAssociatedTokenAccount(
      owner: destination,
      mint: mint,
    );
    final associatedSenderAccount = await getAssociatedTokenAccount(
      owner: source.address,
      mint: mint,
    );
    // Throw an appropriate exception if the sender has no associated
    // token account
    if (associatedSenderAccount == null) {
      throw NoAssociatedTokenAccountException(source.address, mint);
    }
    // Also throw an adequate exception if the recipient has no associated
    // token account
    if (associatedRecipientAccount == null) {
      throw NoAssociatedTokenAccountException(destination, mint);
    }

    final message = TokenProgram.transfer(
      source: associatedSenderAccount.pubkey,
      destination: associatedRecipientAccount.pubkey,
      owner: source.address,
      amount: amount,
      memo: memo,
    );

    final signature = await rpcClient.signAndSendTransaction(
      message,
      [source],
    );
    await waitForSignatureStatus(
      signature,
      status: commitment,
    );

    return signature;
  }

  Future<ProgramAccount?> getAssociatedTokenAccount({
    required String owner,
    required String mint,
  }) async {
    final accounts = await rpcClient.getTokenAccountsByOwner(
      owner,
      TokenAccountsFilter.byMint(mint),
      encoding: Encoding.jsonParsed,
    );
    if (accounts.isEmpty) {
      return null;
    }
    return accounts.first;
  }

  /// Create an account for [account].
  Future<Account> createTokenAccount({
    required String mint,
    required Wallet account,
    required Wallet creator,
    Commitment commitment = Commitment.finalized,
  }) async {
    const space = TokenProgram.neededAccountSpace;
    final rent = await rpcClient.getMinimumBalanceForRentExemption(space);
    final message = TokenProgram.createAccount(
      address: account.address,
      owner: creator.address,
      mint: mint,
      rent: rent,
      space: space,
    );
    final signature = await rpcClient.signAndSendTransaction(
      message,
      [creator, account],
    );
    await waitForSignatureStatus(
      signature,
      status: commitment,
    );

    // TODO(IA): need to check if it is executable and grab the rentEpoch
    return Account(
      owner: account.address,
      lamports: 0,
      executable: false,
      rentEpoch: 0,
      data: null,
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
    String? owner,
    required String mint,
    required Wallet funder,
    Commitment commitment = Commitment.finalized,
  }) async {
    final effectiveOwner = owner ?? funder.address;

    final token = await createReadonlyToken(mint: mint);
    final derivedAddress = await token.computeAssociatedAddress(
      owner: effectiveOwner,
    );
    final message = AssociatedTokenAccountProgram(
      mint: mint,
      address: derivedAddress,
      owner: effectiveOwner,
      funder: funder.address,
    );
    final signature = await rpcClient.signAndSendTransaction(
      message,
      [funder],
    );
    await waitForSignatureStatus(
      signature,
      status: commitment,
    );

    // TODO(IA): populate rentEpoch correctly
    return ProgramAccount(
      pubkey: derivedAddress,
      account: Account(
        owner: effectiveOwner,
        lamports: 0,
        executable: false,
        rentEpoch: 0,
        data: null,
      ),
    );
  }

  /// Whether this wallet has an associated token account for the SPL token [mint].
  Future<bool> hasAssociatedTokenAccount({
    required String owner,
    required String mint,
  }) async {
    Iterable<ProgramAccount> accounts;
    final token = await createReadonlyToken(mint: mint);
    final associatedTokenAddress = await token.computeAssociatedAddress(
      owner: owner,
    );
    try {
      accounts = await rpcClient.getTokenAccountsByOwner(
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
    final token = await createReadonlyToken(mint: mint);
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
      rpcClient.getTokenAccountBalance(
        await getProgramAccountAddress(owner: owner, mint: mint),
        commitment: commitment,
      );

  /// Create a read write account.
  Future<SplToken> createReadWriteToken({
    required String mint,
    required Wallet owner,
  }) =>
      _withOptionalOwner(mint: mint, owner: owner);

  /// Create a readonly account for [mint].
  Future<SplToken> createReadonlyToken({required String mint}) =>
      _withOptionalOwner(mint: mint);

  SubscriptionClient _createSubscriptionClient() =>
      SubscriptionClient(_websocketUrl);

  /// Passing [owner] makes this a writeable token.
  Future<SplToken> _withOptionalOwner({
    required String mint,
    Wallet? owner,
  }) async {
    // TODO(IA): perhaps delay this or use a user provided token information
    final supplyValue = await rpcClient.getTokenSupply(mint);

    return SplToken(
      decimals: supplyValue.decimals,
      supply: BigInt.parse(supplyValue.amount),
      mint: mint,
      owner: owner,
    );
  }
}
