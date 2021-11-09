import 'package:solana/solana.dart';
import 'package:solana/src/crypto/ed25519_hd_keypair.dart';
import 'package:solana/src/solana_client/solana_client.dart';

Future<void> airdrop(
  SolanaClient client,
  Ed25519HDKeyPair wallet, {
  int? sol,
  int? lamports,
}) async {
  // Request some tokens first
  final int? amount = sol != null ? sol * lamportsPerSol : lamports;
  if (amount == null) {
    throw const FormatException('either specify "sol" or "lamports"');
  }
  final txSignature = await client.requestAirdrop(
    pubKey: wallet.address,
    lamports: amount,
  );
  await client.waitForSignatureStatus(txSignature, Commitment.finalized);
}
