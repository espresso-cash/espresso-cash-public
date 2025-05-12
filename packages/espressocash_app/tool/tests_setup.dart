// ignore_for_file: avoid_print, test code

import 'package:solana/solana.dart';

import '../test/keys/keys.dart';
import '../test/utils.dart';

Future<void> main() async {
  final mintAuthority = await Ed25519HDKeyPair.fromPrivateKeyBytes(
    privateKey: mintAuthorityPrivateKey,
  );

  final solanaClient = createTestSolanaClient();
  await solanaClient.createAndFundAccount(mintAuthority.address, sol: 1000);
  print('mint authority setup completed: ${mintAuthority.address}');

  // Mint a few tokens
  final tokenKeys = [token1PrivateKey, token2PrivateKey, token3PrivateKey];
  final List<Ed25519HDKeyPair> tokenPubKeys = [];
  for (final tokenKey in tokenKeys) {
    final key = await Ed25519HDKeyPair.fromPrivateKeyBytes(privateKey: tokenKey);

    tokenPubKeys.add(key);

    await solanaClient.createToken(mintAuthority, key);
    print('token ${key.address} created');
  }

  final accountKey = await Ed25519HDKeyPair.fromMnemonic(accountMnemonic);

  await solanaClient.createAndFundAccount(accountKey.address, sol: 1000);
  print('created test account');

  await Future.wait(
    tokenPubKeys.map(
      (Ed25519HDKeyPair token) =>
          solanaClient.airdropSplTokens(accountKey.publicKey, token, amount: 100_000),
    ),
  );

  print('airdropped some tokens');

  print('all done');
}
