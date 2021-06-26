import 'package:solana/solana.dart';
import 'package:solana/src/hd_keypair.dart';

Future<void> airdrop(
  RPCClient client,
  HDKeyPair wallet, {
  int? sol,
  int? lamports,
}) async {
  // Request some tokens first
  final int? amount = sol != null ? sol * lamportsPerSol : lamports;
  if (amount == null) {
    throw const FormatException('either specify "sol" or "lamports"');
  }
  final txSignature = await client.requestAirdrop(wallet.address, amount);
  await client.waitForSignatureStatus(txSignature, Commitment.finalized);
}
