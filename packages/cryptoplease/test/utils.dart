import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:solana/dto.dart';
import 'package:solana/solana.dart';

import 'keys/keys.dart';

extension SolanaClientExt on SolanaClient {
  Future<void> createToken(
    Ed25519HDKeyPair mintAuthority,
    Ed25519HDKeyPair mint,
  ) async {
    final mintRent = await rpcClient.getMinimumBalanceForRentExemption(
      TokenProgram.neededMintAccountSpace,
    );

    final tokenOwnerAddress = await findAssociatedTokenAddress(
      owner: mintAuthority.publicKey,
      mint: mint.publicKey,
    );

    final message = Message(
      instructions: [
        SystemInstruction.createAccount(
          fundingAccount: mintAuthority.publicKey,
          newAccount: mint.publicKey,
          lamports: mintRent,
          space: TokenProgram.neededMintAccountSpace,
          owner: TokenProgram.id,
        ),
        TokenInstruction.initializeMint(
          mint: mint.publicKey,
          mintAuthority: mintAuthority.publicKey,
          decimals: _tokenDecimals,
        ),
        AssociatedTokenAccountInstruction.createAccount(
          funder: mintAuthority.publicKey,
          address: tokenOwnerAddress,
          owner: mintAuthority.publicKey,
          mint: mint.publicKey,
        ),
        TokenInstruction.mintTo(
          amount: 10000000,
          mint: mint.publicKey,
          destination: tokenOwnerAddress,
          authority: mintAuthority.publicKey,
        ),
      ],
    );

    await waitForSignatureStatus(
      await rpcClient.signAndSendTransaction(
        message,
        [mintAuthority, mint],
      ),
      status: ConfirmationStatus.finalized,
    );
  }

  Future<void> createAndFundAccount(
    String address, {
    required int sol,
  }) async {
    final signature = await rpcClient.requestAirdrop(
      address,
      sol * lamportsPerSol,
    );
    // Fund the mint authority
    await waitForSignatureStatus(
      signature,
      status: ConfirmationStatus.finalized,
    );
  }

  Future<void> airdropSplTokens(
    Ed25519HDPublicKey recipient,
    Token token, {
    required int amount,
  }) async {
    final mintAuthority = await Ed25519HDKeyPair.fromPrivateKeyBytes(
      privateKey: mintAuthorityPrivateKey,
    );

    final recipientAssociatedTokenAccountAddress =
        await findAssociatedTokenAddress(
      owner: recipient,
      mint: token.publicKey,
    );

    final message = Message(
      instructions: [
        AssociatedTokenAccountInstruction.createAccount(
          funder: mintAuthority.publicKey,
          address: recipientAssociatedTokenAccountAddress,
          owner: recipient,
          mint: token.publicKey,
        ),
        TokenInstruction.transferChecked(
          mint: token.publicKey,
          source: await findAssociatedTokenAddress(
            owner: mintAuthority.publicKey,
            mint: token.publicKey,
          ),
          destination: recipientAssociatedTokenAccountAddress,
          owner: mintAuthority.publicKey,
          amount: amount,
          decimals: _tokenDecimals,
        ),
      ],
    );

    final signature = await rpcClient.signAndSendTransaction(
      message,
      [mintAuthority],
    );

    await waitForSignatureStatus(
      signature,
      status: ConfirmationStatus.finalized,
    );
  }
}

const _tokenDecimals = 2;
