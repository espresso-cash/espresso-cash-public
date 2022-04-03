import 'package:solana/solana.dart';

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
