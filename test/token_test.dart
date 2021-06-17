import 'dart:io';

import 'package:bip39/bip39.dart';
import 'package:solana/solana.dart';
import 'package:solana/src/spl_token/spl_token.dart';
import 'package:test/test.dart';

void main() {
  final devnetRpcUrl =
      Platform.environment['DEVNET_RPC_URL'] ?? 'http://127.0.0.1:8899';

  group('Test spl tokens', () {
    final SolanaClient solanaClient = SolanaClient(devnetRpcUrl);
    late SolanaWallet sourceWallet;

    setUpAll(() async {
      sourceWallet = await SolanaWallet.fromMnemonic(
        generateMnemonic(),
        walletIndex: 1,
      );
      await solanaClient.requestAirdrop(
        sourceWallet.address,
        100,
        commitment: TxStatus.confirmed,
      );
    });

    test('It creates a new mint', () async {
      final randomWallet = await SolanaWallet.random();
      final recentBlockhash = await solanaClient.getRecentBlockhash();
      final message = TokenMessage.createToken(
        authority: sourceWallet.address,
        mint: randomWallet.address,
        decimals: 2,
      );
      await solanaClient.sendTransaction(SignedTx(
        messageBytes: message.compile(recentBlockhash),
      ));
      print(message);
    });
  }, skip: true);
}
