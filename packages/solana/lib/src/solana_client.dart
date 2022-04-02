import 'dart:async';

import 'package:solana/solana.dart';
import 'package:solana/src/encoder/encoder.dart';
import 'package:solana/src/programs/token_program/raw_mint.dart';
import 'package:solana/src/rpc/dto/dto.dart';

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
  }) async {
    final subscriptionClient = _createSubscriptionClient();

    try {
      await subscriptionClient.waitForSignatureStatus(
        signature,
        status: status,
        timeout: timeout ?? _timeout,
      );
    } finally {
      subscriptionClient.close();
    }
  }

  /// Creates a solana transfer message to send [lamports] SOL tokens from
  /// [source] to [destination].
  ///
  /// To add additional data to the transaction you can use the [memo] field. It
  /// accepts an arbitrary string of utf-8 characters. As of now the maximum
  /// allowed length for the memo is 566 bytes of utf-8 data.
  Future<void> transferLamports({
    required Ed25519HDKeyPair source,
    required Ed25519HDPublicKey destination,
    required int lamports,
    String? memo,
    Commitment commitment = Commitment.finalized,
  }) async {
    final instructions = [
      SystemInstruction.transfer(
        fundingAccount: source.publicKey,
        recipientAccount: destination,
        lamports: lamports,
      ),
      if (memo != null)
        MemoInstruction(signers: [source.publicKey], memo: memo),
    ];

    return _signSendWait(
      message: Message(instructions: instructions),
      signers: [source],
      commitment: commitment,
    );
  }

  Future<ProgramAccount?> getAssociatedTokenAccount({
    required Ed25519HDPublicKey owner,
    required Ed25519HDPublicKey mint,
  }) async {
    final accounts = await rpcClient.getTokenAccountsByOwner(
      owner.toBase58(),
      TokenAccountsFilter.byMint(mint.toBase58()),
      encoding: Encoding.jsonParsed,
    );
    if (accounts.isEmpty) return null;

    return accounts.first;
  }

  Future<Mint> getMint({
    required Ed25519HDPublicKey address,
    Commitment commitment = Commitment.finalized,
  }) async {
    final info = await rpcClient.getAccountInfo(
      address.toBase58(),
      commitment: commitment,
      encoding: Encoding.base64,
    );

    if (info == null) throw const TokenAccountNotFoundException();

    final raw = RawMint.fromBorsh((info.data as BinaryAccountData).data);

    return Mint(
      address: address,
      supply: BigInt.from(raw.supply),
      decimals: raw.decimals,
      isInitialized: raw.isInitialized == 1,
      mintAuthority: raw.mintAuthorityOption == 0
          ? null
          : Ed25519HDPublicKey(raw.mintAuthority),
      freezeAuthority: raw.freezeAuthorityOption == 0
          ? null
          : Ed25519HDPublicKey(raw.freezeAuthority),
    );
  }

  /// Get the minimum lamport balance for a rent-exempt mint.
  Future<int> getMinimumBalanceForMintRentExemption({
    Commitment? commitment,
  }) =>
      rpcClient.getMinimumBalanceForRentExemption(
        TokenProgram.neededMintAccountSpace,
        commitment: commitment,
      );

  /// Create a new token owned by [mintAuthority] with number of [decimals].
  ///
  /// Optionally, you can specify a [freezeAuthority]. By default the
  /// [freezeAuthority] is not set.
  ///
  /// Finally, you can also send the transaction with optional [commitment].
  Future<Mint> initializeMint({
    required Ed25519HDKeyPair mintAuthority,
    required Ed25519HDKeyPair mint,
    required int decimals,
    Ed25519HDPublicKey? freezeAuthority,
    Commitment commitment = Commitment.finalized,
  }) async {
    const space = TokenProgram.neededMintAccountSpace;
    final rent = await rpcClient.getMinimumBalanceForRentExemption(
      space,
      commitment: commitment,
    );

    final instructions = TokenInstruction.createAccountAndInitializeMint(
      mint: mint.publicKey,
      mintAuthority: mintAuthority.publicKey,
      freezeAuthority: freezeAuthority,
      rent: rent,
      space: space,
      decimals: decimals,
    );

    final message = Message(instructions: instructions);

    await _signSendWait(
      message: message,
      signers: [mintAuthority, mint],
      commitment: commitment,
    );

    return getMint(address: mint.publicKey);
  }

  /// Mint [destination] with [amount] tokens.
  Future<void> transferMint({
    required Ed25519HDPublicKey destination,
    required int amount,
    required Ed25519HDPublicKey mint,
    required Wallet owner,
    Commitment commitment = Commitment.finalized,
  }) async {
    final instruction = TokenInstruction.mintTo(
      mint: mint,
      destination: destination,
      authority: owner.publicKey,
      amount: amount,
    );

    await _signSendWait(
      message: Message.only(instruction),
      signers: [owner],
      commitment: commitment,
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
    Ed25519HDPublicKey? owner,
    required Ed25519HDPublicKey mint,
    required Wallet funder,
    Commitment commitment = Commitment.finalized,
  }) async {
    final effectiveOwner = owner ?? funder.publicKey;

    final derivedAddress = await findAssociatedTokenAddress(
      owner: effectiveOwner,
      mint: mint,
    );
    final instruction = AssociatedTokenAccountInstruction.createAccount(
      mint: mint,
      address: derivedAddress,
      owner: effectiveOwner,
      funder: funder.publicKey,
    );

    await _signSendWait(
      message: Message.only(instruction),
      signers: [funder],
      commitment: commitment,
    );

    // TODO(IA): populate rentEpoch correctly
    return ProgramAccount(
      pubkey: derivedAddress.toBase58(),
      account: Account(
        owner: effectiveOwner.toBase58(),
        lamports: 0,
        executable: false,
        rentEpoch: 0,
        data: null,
      ),
    );
  }

  /// Request airdrop for [lamports] amount to this wallet's account.
  ///
  /// For [commitment] parameter description [see this document][1]
  /// [Commitment.processed] is not supported as [commitment].
  ///
  /// [1]: https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment
  Future<String> requestAirdrop({
    required Ed25519HDPublicKey address,
    required int lamports,
    Commitment commitment = Commitment.finalized,
  }) async {
    final signature = await rpcClient.requestAirdrop(
      address.toBase58(),
      lamports,
      commitment: commitment,
    );
    await waitForSignatureStatus(
      signature,
      status: commitment,
    );

    return signature;
  }

  /// Create an account for [account].
  Future<Account> createTokenAccount({
    required Ed25519HDPublicKey mint,
    required Wallet account,
    required Wallet creator,
    Commitment commitment = Commitment.finalized,
  }) async {
    const space = TokenProgram.neededAccountSpace;
    final rent = await rpcClient.getMinimumBalanceForRentExemption(space);
    final instructions = TokenInstruction.createAndInitializeAccount(
      address: account.publicKey,
      owner: creator.publicKey,
      mint: mint,
      rent: rent,
      space: space,
    );
    await _signSendWait(
      message: Message(instructions: instructions),
      signers: [creator, account],
      commitment: commitment,
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

  /// Whether this wallet has an associated token account for the SPL token [mint].
  Future<bool> hasAssociatedTokenAccount({
    required Ed25519HDPublicKey owner,
    required Ed25519HDPublicKey mint,
  }) async {
    Iterable<ProgramAccount> accounts;
    final associatedTokenAddress = await findAssociatedTokenAddress(
      owner: owner,
      mint: mint,
    );
    try {
      accounts = await rpcClient.getTokenAccountsByOwner(
        owner.toBase58(),
        TokenAccountsFilter.byMint(mint.toBase58()),
        encoding: Encoding.jsonParsed,
      );
    } on FormatException {
      accounts = [];
    }

    return accounts.any((a) => a.pubkey == associatedTokenAddress.toBase58());
  }

  Future<void> _signSendWait({
    required Message message,
    required List<Ed25519HDKeyPair> signers,
    required Commitment commitment,
  }) async {
    final tx = await signTransaction(
      await rpcClient.getRecentBlockhash(),
      message,
      signers,
    );
    final signature = await rpcClient.sendTransaction(
      tx.encode(),
      commitment: commitment,
    );

    return waitForSignatureStatus(signature, status: commitment);
  }

  SubscriptionClient _createSubscriptionClient() =>
      SubscriptionClient(_websocketUrl);
}
