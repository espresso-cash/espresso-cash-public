import 'dart:io';

import 'package:bip39/bip39.dart';
import 'package:solana/solana.dart';
import 'package:solana/src/encoder/encoder.dart';
import 'package:solana/src/spl_token/spl_token.dart';
import 'package:test/test.dart';

void main() {
  final devnetRpcUrl =
      Platform.environment['DEVNET_RPC_URL'] ?? 'http://127.0.0.1:8899';

  group('Test spl tokens', () {
    final SolanaClient solanaClient = SolanaClient(devnetRpcUrl);
    late final SolanaWallet sourceWallet;
    late final SolanaWallet mintWallet;

    setUpAll(() async {
      mintWallet = await SolanaWallet.random();
      sourceWallet = await SolanaWallet.fromMnemonic(
        generateMnemonic(),
        walletIndex: 1,
      );
      final txSignature = await solanaClient.requestAirdrop(
        sourceWallet.address,
        500 * lamportsPerSol,
      );
      await solanaClient.waitForSignatureStatus(
        txSignature,
        Commitment.finalized,
      );
    });

    test('It creates a new mint', () async {
      final recentBlockhash = await solanaClient.getRecentBlockhash();
      const allocatedSpace = TokenProgram.requiredAccountSpace;
      final requiredBalance =
          await solanaClient.getMinimumBalanceForRentExemption(allocatedSpace);
      final message = TokenMessage.createMint(
        authorityPubkey: sourceWallet.address,
        freezePubkey: sourceWallet.address,
        mintPubkey: mintWallet.address,
        requiredBalance: requiredBalance,
        allocatedSpace: allocatedSpace,
        decimals: 2,
      );
      final messageBytes = message.compile(recentBlockhash);
      final signature1 = await sourceWallet.sign(messageBytes);
      final signature2 = await mintWallet.sign(messageBytes);
      await solanaClient.sendTransaction(
        SignedTx(
          messageBytes: messageBytes,
          signatures: [signature1, signature2],
        ),
      );
    });
  });
}
