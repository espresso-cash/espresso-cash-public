import 'package:solana/src/crypto/ed25519_hd_keypair.dart';
import 'package:solana/src/encoder/buffer.dart';
import 'package:solana/src/helpers.dart';
import 'package:solana/src/programs/associated_token_account_program/associated_token_account_program.dart';
import 'package:solana/src/programs/token_program/token_program.dart';

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
  final String mint;
  final Ed25519HDKeyPair? owner;
}

/// Compute and derive the associated token address of [owner]
Future<Ed25519HDPublicKey> findAssociatedTokenAddress({
  required Ed25519HDPublicKey owner,
  required Ed25519HDPublicKey mint,
}) =>
    findProgramAddress(
      seeds: [
        owner.bytes,
        Buffer.fromBase58(TokenProgram.programId),
        mint.bytes
      ],
      programId: Ed25519HDPublicKey.fromBase58(
        AssociatedTokenAccountProgram.programId,
      ),
    );
