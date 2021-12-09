import 'package:solana/solana.dart';
import 'package:solana/src/crypto/ed25519_hd_keypair.dart';
import 'package:solana/src/rpc/dto/commitment.dart';
import 'package:solana/src/subscription_client/subscription_client.dart';

Future<void> airdrop(
  RpcClient client,
  SubscriptionClient subscriptionClient,
  Ed25519HDKeyPair wallet, {
  int? sol,
  int? lamports,
}) async {
  // Request some tokens first
  final int? amount = sol != null ? sol * lamportsPerSol : lamports;
  if (amount == null) {
    throw const FormatException('either specify "sol" or "lamports"');
  }
  final txSignature = await client.requestAirdrop(wallet.address, amount);

  await subscriptionClient.waitForSignatureStatus(
    txSignature,
    status: Commitment.finalized,
  );
}
