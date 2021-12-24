import 'package:solana/src/constants.dart';
import 'package:solana/src/crypto/ed25519_hd_keypair.dart';
import 'package:solana/src/rpc/client.dart';
import 'package:solana/src/rpc/dto/account.dart';
import 'package:solana/src/rpc/dto/commitment.dart';
import 'package:solana/src/subscription_client/subscription_client.dart';
import 'package:solana/src/wallet.dart';
import 'package:test/test.dart';

import 'config.dart';

void main() {
  test('accountSubscribe must return account owned by the system program',
      () async {
    const originalLamports = lamportsPerSol;
    final sender = await Ed25519HDKeyPair.random();
    final recipient = await Ed25519HDKeyPair.random();
    final rpcClient = RpcClient(devnetRpcUrl);
    final signature = await rpcClient.requestAirdrop(
      sender.address,
      originalLamports,
    );

    final subscriptionClient =
        await SubscriptionClient.fromUrl(devnetWebsocketUrl);

    await subscriptionClient.signatureSubscribe(signature).first;

    // System program
    final accountStream = subscriptionClient.accountSubscribe(sender.address);

    // Now send some tokens
    final wallet = Wallet(
      sender,
      rpcClient: rpcClient,
      subscriptionClient: subscriptionClient,
    );
    await wallet.transfer(
      destination: recipient.address,
      commitment: Commitment.confirmed,
      lamports: lamportsPerSol ~/ 2,
    );

    final account = await accountStream.firstWhere(
      (Account data) => true,
    );

    expect(account.lamports, lessThan(originalLamports));
  }, timeout: Timeout(Duration(minutes: 1)));
}
