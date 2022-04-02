import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/solana.dart';

part 'mint.freezed.dart';

/// Information about a mint.
@freezed
class Mint with _$Mint {
  const factory Mint({
    /// Address of the mint
    required Ed25519HDPublicKey address,

    /// Total supply of tokens.
    required BigInt supply,

    /// Number of base 10 digits to the right of the decimal place.
    required int decimals,

    /// Optional authority used to mint new tokens.
    ///
    /// The mint authority may only be provided during mint creation. If no mint
    /// authority is present then the mint has a fixed supply and no further
    /// tokens may be minted.
    Ed25519HDPublicKey? mintAuthority,

    /// Is this mint initialized
    required bool isInitialized,

    /// Optional authority to freeze token accounts.
    Ed25519HDPublicKey? freezeAuthority,
  }) = _Mint;
}

/// Compute and derive the associated token address of [owner].
Future<Ed25519HDPublicKey> findAssociatedTokenAddress({
  required Ed25519HDPublicKey owner,
  required Ed25519HDPublicKey mint,
}) =>
    Ed25519HDPublicKey.findProgramAddress(
      seeds: [owner.bytes, TokenProgram.id.toBuffer(), mint.bytes],
      programId: AssociatedTokenAccountProgram.id,
    );
