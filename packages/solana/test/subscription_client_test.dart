import 'package:solana/solana.dart';
import 'package:solana/src/crypto/ed25519_hd_keypair.dart';
import 'package:solana/src/rpc_client/rpc_client.dart';
import 'package:solana/src/subscription_client/maybe_error.dart';
import 'package:solana/src/subscription_client/subscription_client.dart';
import 'package:test/test.dart';

import 'config.dart';

void main() {
  test('accountSubscribe must return account owned by the system program',
      () async {
    const originalLamports = 10 * lamportsPerSol;
    final sender = await Ed25519HDKeyPair.random();
    final recipient = await Ed25519HDKeyPair.random();
    final rpcClient = RPCClient(
      rpcUrl: devnetRpcUrl,
      websocketUrl: devnetWebsocketUrl,
    );
    final signature = await rpcClient.requestAirdrop(
      pubKey: sender.address,
      lamports: originalLamports,
    );

    final client = SubscriptionClient(devnetWebsocketUrl);
    final MaybeError result =
        await client.signatureSubscribe(signature).firstWhere((_) => true);

    expect(result.err, isNull);
    // System program
    final accountStream = client.accountSubscribe(sender.address);

    // Now send some tokens
    final wallet = Wallet(signer: sender, rpcClient: rpcClient);
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
