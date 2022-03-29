import 'package:cryptoplease/bl/solana_helpers.dart';
import 'package:cryptoplease/bl/tokens/token.dart' hide SplToken;
import 'package:solana/dto.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

import 'keys/keys.dart';

Future<SplToken> createNewToken({
  required SolanaClient solanaClient,
  required int decimals,
  required int supply,
  required String transferSomeToAddress,
  required int transferSomeToAmount,
}) async {
  // This is the authority that will create the token and be able to
  // emit currency
  final tokenMintAuthority = await Ed25519HDKeyPair.random();
  // Put some tokens in the authority wallet
  await solanaClient.requestAirdrop(
    address: tokenMintAuthority.address,
    lamports: 5 * lamportsPerSol,
  );

  // Now we have SOL to create the token
  final splToken = await solanaClient.initializeMint(
    decimals: 2,
    owner: tokenMintAuthority,
  );
  // Now lets create an account to store the supply. All SPL token transfer
  // must be done to an associated token account which belongs to the specific
  // token
  //
  // The mint authority will also, own the total supply of the token
  final supplyAccount = await solanaClient.createAssociatedTokenAccount(
    owner: tokenMintAuthority.address,
    funder: tokenMintAuthority,
    mint: splToken.mint,
  );
  // Now we have a spl token, let's add the supply to it
  await solanaClient.transferMint(
    destination: supplyAccount.pubkey,
    amount: supply,
    mint: splToken.mint,
    owner: tokenMintAuthority,
  );

  // We must check if the recipient has an associated token account, if not
  // we have to create it
  final associatedAccount = await solanaClient.getAssociatedTokenAccount(
    owner: transferSomeToAddress,
    mint: splToken.mint,
  );
  if (associatedAccount == null) {
    await solanaClient.createAssociatedTokenAccount(
      owner: transferSomeToAddress,
      funder: tokenMintAuthority,
      mint: splToken.mint,
    );
  }

  // And finally transfer them from the supply account to the destination account,
  // this is similar to what a faucet does
  await solanaClient.transferSplToken(
    source: tokenMintAuthority,
    destination: transferSomeToAddress,
    amount: transferSomeToAmount,
    mint: splToken.mint,
  );

  return splToken;
}

extension SolanaClientExt on SolanaClient {
  Future<void> createToken(
    Ed25519HDKeyPair mintAuthority,
    Ed25519HDKeyPair mint,
  ) async {
    final mintRent = await rpcClient.getMinimumBalanceForRentExemption(
      TokenProgram.neededMintAccountSpace,
    );

    final tokenOwnerAddress = await computeAssociatedTokenAccountAddress(
      owner: mintAuthority.address,
      mint: mint.address,
    );

    final message = Message(
      instructions: [
        SystemInstruction.createAccount(
          fromPubKey: mintAuthority.address,
          pubKey: mint.address,
          lamports: mintRent,
          space: TokenProgram.neededMintAccountSpace,
          owner: TokenProgram.programId,
        ),
        TokenInstruction.initializeMint(
          mint: mint.address,
          mintAuthority: mintAuthority.address,
          decimals: _tokenDecimals,
        ),
        AssociatedTokenAccountInstruction(
          funder: mintAuthority.address,
          address: tokenOwnerAddress,
          owner: mintAuthority.address,
          mint: mint.address,
        ),
        TokenInstruction.mintTo(
          amount: 10000000,
          mint: mint.address,
          destination: tokenOwnerAddress,
          authority: mintAuthority.address,
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
    String recipient,
    Token token, {
    required int amount,
  }) async {
    final mintAuthority = await Ed25519HDKeyPair.fromPrivateKeyBytes(
      privateKey: mintAuthorityPrivateKey,
    );

    final recipientAssociatedTokenAccountAddress =
        await computeAssociatedTokenAccountAddress(
      owner: recipient,
      mint: token.address,
    );

    final message = Message(
      instructions: [
        AssociatedTokenAccountInstruction(
          funder: mintAuthority.address,
          address: recipientAssociatedTokenAccountAddress,
          owner: recipient,
          mint: token.address,
        ),
        TokenInstruction.transferChecked(
          mint: token.address,
          source: await computeAssociatedTokenAccountAddress(
            owner: mintAuthority.address,
            mint: token.address,
          ),
          destination: recipientAssociatedTokenAccountAddress,
          owner: mintAuthority.address,
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
