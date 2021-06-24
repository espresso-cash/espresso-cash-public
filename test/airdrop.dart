import 'package:solana/solana.dart';
import 'package:solana/src/signer.dart';
import 'package:solana/src/types/commitment.dart';

Future<void> airdrop(
  RPCClient client,
  Signer wallet, {
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
