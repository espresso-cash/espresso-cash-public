import 'dart:async';

import 'package:solana/dto.dart';
import 'package:solana/solana.dart';
import 'package:test/test.dart';

import 'config.dart';

void main() {
  test(
    'accountSubscribe must return account owned by the system program',
    () async {
      const originalLamports = lamportsPerSol;
      final sender = await Ed25519HDKeyPair.random();
      final recipient = await Ed25519HDKeyPair.random();
      final rpcClient = RpcClient(devnetRpcUrl);
      final signature = await rpcClient.requestAirdrop(
        sender.address,
        originalLamports,
      );

      final subscriptionClient = SubscriptionClient.connect(devnetWebsocketUrl);

      final result =
          await subscriptionClient.signatureSubscribe(signature).first;
      expect(result.err, isNull);

      // System program
      final accountStream = subscriptionClient.accountSubscribe(sender.address);

      // Now send some tokens
      await createTestSolanaClient().transferLamports(
        destination: recipient.publicKey,
        commitment: Commitment.confirmed,
        lamports: lamportsPerSol ~/ 2,
        source: sender,
      );

      final account = await accountStream.firstWhere(
        (Account data) => data.lamports < originalLamports,
      );

      expect(account.lamports, lessThan(originalLamports));
    },
    timeout: const Timeout(Duration(minutes: 1)),
  );

  test('waitForSignatureStatus throws Exception on timout', () async {
    final client = SubscriptionClient.connect(devnetWebsocketUrl);
    expect(
      () => client.waitForSignatureStatus(
        '3mx8XfKKwJHk3r5gezhedyzZTaDYgyA31jWp7DTfvifRJkouaA7kWwcReP1XRCvyAXeAgsUWQrTQffhR8rWHHCvN',
        status: ConfirmationStatus.finalized,
        timeout: Duration.zero,
      ),
      throwsA(isA<TimeoutException>()),
    );
  });
}
