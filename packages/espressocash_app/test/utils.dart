import 'dart:io';

import 'package:espressocash_app/features/tokens/token.dart';
import 'package:solana/dto.dart';
import 'package:solana/solana.dart';

import 'keys/keys.dart';

final devnetRpcUrl =
    Platform.environment['SOLANA_RPC_URL'] ?? 'http://127.0.0.1:8899';
final devnetWebsocketUrl =
    Platform.environment['SOLANA_WEBSOCKET_URL'] ?? 'ws://127.0.0.1:8900';

SolanaClient createTestSolanaClient() => SolanaClient(
      rpcUrl: Uri.parse(devnetRpcUrl),
      websocketUrl: Uri.parse(devnetWebsocketUrl),
    );

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
        commitment: Commitment.confirmed,
      ),
      status: ConfirmationStatus.confirmed,
    );
  }

  Future<void> createAndFundAccount(
    String address, {
    required int sol,
  }) async {
    final signature = await rpcClient.requestAirdrop(
      address,
      sol * lamportsPerSol,
      commitment: Commitment.confirmed,
    );
    // Fund the mint authority
    await waitForSignatureStatus(
      signature,
      status: ConfirmationStatus.confirmed,
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
      commitment: Commitment.confirmed,
    );

    await waitForSignatureStatus(
      signature,
      status: ConfirmationStatus.confirmed,
    );
  }
}

const _tokenDecimals = 2;
