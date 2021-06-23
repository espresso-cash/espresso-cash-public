import 'dart:io';

import 'package:solana/solana.dart';
import 'package:solana/src/encoder/encoder.dart';
import 'package:solana/src/spl_token/spl_token.dart';
import 'package:test/test.dart';

Future<TxSignature> signAndSend(
  SolanaClient client,
  Message message,
  Blockhash recentBlockhash,
  List<SolanaWallet> signers,
) async {
  final messageBytes = message.compile(
    recentBlockhash: recentBlockhash,
  );
  final signatures = await Future.wait(
    signers.map((s) => s.sign(messageBytes)),
  );
  return client.sendTransaction(
    SignedTx(
      messageBytes: messageBytes,
      signatures: signatures,
    ),
  );
}

void main() {
  final devnetRpcUrl =
      Platform.environment['DEVNET_RPC_URL'] ?? 'http://127.0.0.1:8899';

  group('Test spl tokens', () {
    final SolanaClient solanaClient = SolanaClient(devnetRpcUrl);
    late final SolanaWallet mint;
    late final SolanaWallet owner;
    late final SolanaWallet account;
    late final Blockhash recentBlockhash;

    setUpAll(() async {
      owner = await SolanaWallet.random();
      mint = await SolanaWallet.random();
      account = await SolanaWallet.random();
      final txSignature = await solanaClient.requestAirdrop(
        owner.address,
        500 * lamportsPerSol,
      );
      await solanaClient.waitForSignatureStatus(
        txSignature,
        Commitment.finalized,
      );
      recentBlockhash = await solanaClient.getRecentBlockhash();
    });

    test('Can create a new mint', () async {
      const space = TokenProgram.neededMintAccountSpace;
      final rent = await solanaClient.getMinimumBalanceForRentExemption(space);
      final message = TokenMessage.createMint(
        mint: mint.address,
        mintAuthority: owner.address,
        freezeAuthority: owner.address,
        rent: rent,
        space: space,
        decimals: 2,
      );
      final signature = await signAndSend(
        solanaClient,
        message,
        recentBlockhash,
        [
          owner,
          mint,
        ],
      );
      await solanaClient.waitForSignatureStatus(
        signature,
        Commitment.finalized,
      );
    });

    test('Can create an account', () async {
      const space = TokenProgram.neededAccountSpace;
      final rent = await solanaClient.getMinimumBalanceForRentExemption(space);
      final message = TokenMessage.createAccount(
        pubKey: account.address,
        owner: owner.address,
        mint: mint.address,
        rent: rent,
        space: space,
      );
      final signature = await signAndSend(
        solanaClient,
        message,
        recentBlockhash,
        [
          owner,
          account,
        ],
      );
      await solanaClient.waitForSignatureStatus(
        signature,
        Commitment.finalized,
      );
    });

    test('Can get spl_token supply', () async {
      final TokenSupplyResult supplyResult = await solanaClient.getTokenSupply(
        mint.address,
      );
      final TokenSupply tokenSupply = supplyResult.value;

      expect(int.parse(tokenSupply.amount), equals(0));
    });

    test('It can mint the newly created token', () async {
      final message = TokenMessage.mintTo(
        mint: mint.address,
        destination: account.address,
        owner: owner.address,
        amount: 1000000000000,
      );
      final signature = await signAndSend(
        solanaClient,
        message,
        recentBlockhash,
        [
          owner,
        ],
      );
      await solanaClient.waitForSignatureStatus(
        signature,
        Commitment.finalized,
      );
    });
  });
}
