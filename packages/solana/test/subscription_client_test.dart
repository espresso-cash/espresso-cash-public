import 'package:solana/solana.dart';
import 'package:solana/src/crypto/ed25519_hd_keypair.dart';
import 'package:solana/src/solana_client/solana_client.dart';
import 'package:solana/src/subscription_client/maybe_error.dart';
import 'package:test/test.dart';

import 'config.dart';

void main() {
  test('lazy initialization only calls connect once', () async {
    final client = SolanaClient(
      rpcUrl: devnetRpcUrl,
      websocketUrl: devnetWebsocketUrl,
    );
    final List<Future<int>> futures = [];
    // Create a lot of futures with a subscription. If this was to call
    // the `_getWebsocket()` function "concurrently" and not initialize
    // late final variables correctly, it would throw an exception
    for (int i = 0; i < 5; ++i) {
      futures.add(client.rootSubscribe().first);
    }

    // Wait for all the results
    final values = (await Future.wait(futures)).toList(growable: false);
    // All the values are equal, so let's check that they are
    expect(
      values.fold(0, (int t, int v) => t + v),
      equals(values.length * values.first),
    );
  });

  test('accountSubscribe must return account owned by the system program',
      () async {
    const originalLamports = 10 * lamportsPerSol;
    final sender = await Ed25519HDKeyPair.random();
    final recipient = await Ed25519HDKeyPair.random();
    final client = SolanaClient(
      rpcUrl: devnetRpcUrl,
      websocketUrl: devnetWebsocketUrl,
    );
    final signature = await client.requestAirdrop(
      pubKey: sender.address,
      lamports: originalLamports,
    );

    final MaybeError result =
        await client.signatureSubscribe(signature).firstWhere((_) => true);

    expect(result.err, isNull);
    // System program
    final accountStream = client.accountSubscribe(sender.address);

    // Now send some tokens
    final wallet = Wallet(signer: sender, client: client);
    await wallet.transfer(
      destination: recipient.address,
      commitment: Commitment.confirmed,
      lamports: lamportsPerSol,
    );

    final account = await accountStream.firstWhere(
      (Account data) => true,
    );

    expect(account.lamports, lessThan(originalLamports));
  });
}
