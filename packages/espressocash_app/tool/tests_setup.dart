// ignore_for_file: avoid_print

import 'package:espressocash_app/features/tokens/token_list.dart';
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
  for (final tokenKey in tokenKeys) {
    final key = await Ed25519HDKeyPair.fromPrivateKeyBytes(
      privateKey: tokenKey,
    );

    await solanaClient.createToken(mintAuthority, key);
    print('token ${key.address} created');
  }

  final accountKey = await Ed25519HDKeyPair.fromMnemonic(accountMnemonic);

  // ignore: invalid_use_of_visible_for_testing_member, part of tests setup
  final tokenList = TokenList(data: localTokenList);

  await solanaClient.createAndFundAccount(accountKey.address, sol: 1000);
  print('created test account');

  await Future.wait(
    tokenList.tokens.map(
      (token) => solanaClient.airdropSplTokens(
        accountKey.publicKey,
        token,
        amount: 100000,
      ),
    ),
  );
  print('airdropped some tokens');

  print('all done');
}
