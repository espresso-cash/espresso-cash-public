part of 'spl_token.dart';

class SPLToken {
  SPLToken._({
    required this.mint,
    required this.supply,
    required this.decimals,
    required this.client,
    this.owner,
  });

  static Future<SPLToken> withOwner({
    required String mint,
    required RPCClient client,
    Signer? owner,
  }) async {
    final supplyResponse = await client.getTokenSupply(mint);
    final supplyValue = supplyResponse.value;
    return SPLToken._(
      decimals: supplyValue.decimals,
      supply: int.parse(supplyValue.amount),
      client: client,
      mint: mint,
      owner: owner,
    );
  }

  static Future<SPLToken> fromMint({
    required String mint,
    required RPCClient client,
  }) =>
      SPLToken.withOwner(
        mint: mint,
        client: client,
      );

  final int decimals;
  final int supply;
  final String mint;
  final Signer? owner;
  final RPCClient client;

  Future<TxSignature> transfer({
    required String source,
    required String destination,
    required int amount,
    required Signer owner,
  }) async {
    final accounts = await getAssociatedAccountFor(owner: destination);
    if (accounts.isEmpty) {
      throw FormatException(
        'there are no associated token accounts for $destination',
      );
    }
    // FIXME: check if the account exists and create it if it does not
    final message = TokenMessage.transfer(
      source: source,
      destination: accounts[0].address,
      owner: owner.address,
      amount: 100,
    );
    return client.signAndSendTransaction(
      message,
      [
        owner,
      ],
    );
  }

  // TODO(IA): return the account
  Future<void> createAccount(
    Signer account,
  ) async {
    final owner = this.owner;
    if (owner == null) {
      throw _readonlyTokenError;
    }
    const space = TokenProgram.neededAccountSpace;
    final rent = await client.getMinimumBalanceForRentExemption(space);
    final message = TokenMessage.createAccount(
      pubKey: account.address,
      owner: owner.address,
      mint: mint,
      rent: rent,
      space: space,
    );
    final signature = await client.signAndSendTransaction(
      message,
      [
        owner,
        if (account.address != owner.address) account,
      ],
    );
    await client.waitForSignatureStatus(signature, TxStatus.finalized);
  }

  Future<String> getAssociatedTokenAddress({
    required String owner,
  }) =>
      findProgramAddress(
        seeds: [
          base58.decode(owner),
          base58.decode(TokenProgram.id),
          base58.decode(mint),
        ],
        programId: AssociatedTokenAccountProgram.id,
      );

  // TODO(IA): return the account
  Future<String> createAssociatedAccount({
    required String owner,
    required Signer funder,
  }) async {
    final associatedAddress = await getAssociatedTokenAddress(
      owner: owner,
    );
    final message = TokenMessage.createAssociatedTokenAccount(
      mint: mint,
      associatedAddress: associatedAddress,
      walletAddress: owner,
      funder: funder.address,
    );
    final signature = await client.signAndSendTransaction(
      message,
      [
        funder,
      ],
    );
    await client.waitForSignatureStatus(
      signature,
      Commitment.finalized,
    );
    return associatedAddress;
  }

  Future<void> mintTo({
    required String destination,
    required int amount,
  }) async {
    final owner = this.owner;
    if (owner == null) {
      throw _readonlyTokenError;
    }
    final message = TokenMessage.mintTo(
      mint: mint,
      destination: destination,
      owner: owner.address,
      amount: amount,
    );
    await client.signAndSendTransaction(
      message,
      [
        owner,
      ],
    );
  }

  Future<List<AssociatedAccount>> getAssociatedAccountFor({
    required String owner,
  }) async =>
      client.getTokenAccountsByOwner(owner, mint: mint);
}

extension TokenExt on RPCClient {
  /// Create a new token owned by [owner] with [decimals] base 10 decimal digits.
  ///
  /// You can optionally specify a [mintAuthority] address. By default the [owner]
  /// address will be used as the _Mint Authority_.
  ///
  /// Also optional, you can specify a [freezeAuthority]. By default the
  /// [freezeAuthority] is not set.
  ///
  /// Finally, you can also send the transaction with optional [commitment].
  Future<SPLToken> newToken({
    required Signer owner,
    required int decimals,
    String? mintAuthority,
    String? freezeAuthority,
    Commitment? commitment,
  }) async {
    const space = TokenProgram.neededMintAccountSpace;
    final mintWallet = await Signer.random();
    final rent = await getMinimumBalanceForRentExemption(space);

    final message = TokenMessage.createMint(
      mint: mintWallet.address,
      mintAuthority: mintAuthority ?? owner.address,
      freezeAuthority: freezeAuthority,
      rent: rent,
      space: space,
      decimals: decimals,
    );
    final signature = await signAndSendTransaction(
      message,
      [
        owner,
        mintWallet,
      ],
      commitment: commitment,
      feePayer: owner.address,
    );
    await waitForSignatureStatus(
      signature,
      Commitment.finalized,
    );

    return SPLToken.withOwner(
      owner: owner,
      mint: mintWallet.address,
      client: this,
    );
  }
}

const _readonlyTokenError = FormatException('this token instance is readonly');
