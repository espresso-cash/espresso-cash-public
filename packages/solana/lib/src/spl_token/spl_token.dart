import 'package:solana/src/crypto/ed25519_hd_keypair.dart';
import 'package:solana/src/crypto/ed25519_hd_public_key.dart';

/// Represents a SPL token program
class SplToken {
  SplToken({
    required this.mint,
    required this.supply,
    required this.decimals,
    this.owner,
  });

  final int decimals;
  final BigInt supply;
  final Ed25519HDPublicKey mint;
  final Ed25519HDKeyPair? owner;
}
