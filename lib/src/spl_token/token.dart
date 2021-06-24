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
    required SolanaClient client,
    SolanaWallet? owner,
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
    required SolanaClient client,
  }) =>
      SPLToken.withOwner(
        mint: mint,
        client: client,
      );

  // FIXME(IA): return the account
  Future<void> createAccount(
    SolanaWallet account,
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
        account,
      ],
    );
    await client.waitForSignatureStatus(signature, TxStatus.finalized);
  }

  Future<String> getAssociatedTokenAddress({
    required String systemAccountAddress,
  }) =>
      findProgramAddress(
        seeds: [
          base58.decode(systemAccountAddress),
          base58.decode(TokenProgram.id),
          base58.decode(mint),
        ],
        programId: AssociatedTokenAccountProgram.id,
      );

  // FIXME(IA): return the account
  Future<String> createAssociatedAccount({
    required String systemAccountAddress,
    required SolanaWallet funder,
  }) async {
    final owner = this.owner;
    if (owner == null) {
      throw _readonlyTokenError;
    }
    final associatedAddress = await getAssociatedTokenAddress(
      systemAccountAddress: systemAccountAddress,
    );
    final message = TokenMessage.createAssociatedTokenAccount(
      mint: mint,
      associatedAddress: associatedAddress,
      walletAddress: systemAccountAddress,
      funder: funder.address,
    );
    final signature = await client.signAndSendTransaction(
      message,
      [
        owner,
      ],
    );
    await client.waitForSignatureStatus(
      signature,
      Commitment.finalized,
    );
    return associatedAddress;
  }

  Future<void> mintTo({
    required String address,
    required int amount,
  }) async {
    final owner = this.owner;
    if (owner == null) {
      throw _readonlyTokenError;
    }
    final message = TokenMessage.mintTo(
      mint: mint,
      destination: address,
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

  final int decimals;
  final int supply;
  final String mint;
  final SolanaWallet? owner;
  final SolanaClient client;
}

extension TokenExt on SolanaClient {
  Future<SPLToken> newToken({
    required SolanaWallet owner,
    required int decimals,
    String? mintAuthority,
    String? freezeAuthority,
    Commitment? commitment,
  }) async {
    const space = TokenProgram.neededMintAccountSpace;
    final mintWallet = await SolanaWallet.random();
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
