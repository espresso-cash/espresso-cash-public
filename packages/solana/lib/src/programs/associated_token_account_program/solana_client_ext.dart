import 'package:solana/dto.dart';
import 'package:solana/solana.dart';

extension SolanaClientAssociatedTokenAccontProgram on SolanaClient {
  /// Whether this wallet has an associated token account for the SPL token
  /// [mint].
  Future<bool> hasAssociatedTokenAccount({
    required Ed25519HDPublicKey owner,
    required Ed25519HDPublicKey mint,
    Commitment commitment = Commitment.finalized,
  }) async {
    final account = await getAssociatedTokenAccount(
      owner: owner,
      mint: mint,
      commitment: commitment,
    );

    return account != null;
  }

  Future<ProgramAccount?> getAssociatedTokenAccount({
    required Ed25519HDPublicKey owner,
    required Ed25519HDPublicKey mint,
    Commitment commitment = Commitment.finalized,
  }) async {
    final accounts = await rpcClient
        .getTokenAccountsByOwner(
          owner.toBase58(),
          TokenAccountsFilter.byMint(mint.toBase58()),
          encoding: Encoding.jsonParsed,
          commitment: commitment,
        )
        .value;
    if (accounts.isEmpty) return null;

    return accounts.first;
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
    TokenProgramType tokenProgramType = TokenProgramType.tokenProgram,
    SignatureCallback? onSigned,
    Commitment commitment = Commitment.finalized,
  }) async {
    final effectiveOwner = owner ?? funder.publicKey;

    final derivedAddress = await findAssociatedTokenAddress(
      owner: effectiveOwner,
      mint: mint,
      tokenProgramType: tokenProgramType,
    );
    final instruction = AssociatedTokenAccountInstruction.createAccount(
      mint: mint,
      address: derivedAddress,
      owner: effectiveOwner,
      funder: funder.publicKey,
      tokenProgramId: tokenProgramType.id,
    );

    await sendAndConfirmTransaction(
      message: Message.only(instruction),
      signers: [funder],
      onSigned: onSigned ?? ignoreOnSigned,
      commitment: commitment,
    );

    // TODO(IA): populate rentEpoch correctly
    return ProgramAccount(
      pubkey: derivedAddress.toBase58(),
      account: Account(
        owner: effectiveOwner.toBase58(),
        lamports: 0,
        executable: false,
        rentEpoch: BigInt.zero,
        data: null,
      ),
    );
  }

  /// Create an account for [account].
  Future<Account> createTokenAccount({
    required Ed25519HDPublicKey mint,
    required Wallet account,
    required Wallet creator,
    SignatureCallback? onSigned,
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
    await sendAndConfirmTransaction(
      message: Message(instructions: instructions),
      signers: [creator, account],
      onSigned: onSigned ?? ignoreOnSigned,
      commitment: commitment,
    );

    // TODO(IA): need to check if it is executable and grab the rentEpoch
    return Account(
      owner: account.address,
      lamports: 0,
      executable: false,
      rentEpoch: BigInt.zero,
      data: null,
    );
  }

  /// Get token [mint] balance for this wallet's account.
  ///
  /// For [commitment] parameter description [see this document][1]
  /// [Commitment.processed] is not supported as [commitment].
  ///
  /// [1]: https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment
  Future<TokenAmount> getTokenBalance({
    required Ed25519HDPublicKey owner,
    required Ed25519HDPublicKey mint,
    TokenProgramType tokenProgramType = TokenProgramType.tokenProgram,
    Commitment commitment = Commitment.finalized,
  }) async {
    final ata = await findAssociatedTokenAddress(
      owner: owner,
      mint: mint,
      tokenProgramType: tokenProgramType,
    );

    return rpcClient
        .getTokenAccountBalance(ata.toBase58(), commitment: commitment)
        .value;
  }
}
