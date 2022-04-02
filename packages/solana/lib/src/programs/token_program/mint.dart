import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/dto.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';
import 'package:solana/src/programs/token_program/raw_mint.dart';

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

Future<Mint?> getMint({
  required RpcClient client,
  required Ed25519HDPublicKey address,
  Commitment commitment = Commitment.finalized,
}) async {
  final info = await client.getAccountInfo(
    address.toBase58(),
    commitment: commitment,
    encoding: Encoding.base64,
  );

  if (info == null) return null;

  final raw = RawMint.fromBorsh((info.data as BinaryAccountData).data);

  return Mint(
    address: address,
    supply: BigInt.from(raw.supply),
    decimals: raw.decimals,
    isInitialized: raw.isInitialized == 1,
    mintAuthority: raw.mintAuthorityOption == 0
        ? null
        : Ed25519HDPublicKey(raw.mintAuthority),
    freezeAuthority: raw.freezeAuthorityOption == 0
        ? null
        : Ed25519HDPublicKey(raw.freezeAuthority),
  );
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

/// Get the minimum lamport balance for a rent-exempt mint.
Future<int> getMinimumBalanceForRentExemption({
  required RpcClient client,
  Commitment? commitment,
}) =>
    client.getMinimumBalanceForRentExemption(
      TokenProgram.neededMintAccountSpace,
      commitment: commitment,
    );

Future<Message> createInitializeMintMessage({
  required RpcClient client,
  required Ed25519HDKeyPair mintAuthority,
  required Ed25519HDKeyPair mint,
  required int decimals,
  Ed25519HDPublicKey? freezeAuthority,
  Commitment commitment = Commitment.finalized,
}) async {
  const space = TokenProgram.neededMintAccountSpace;
  final rent = await client.getMinimumBalanceForRentExemption(
    space,
    commitment: commitment,
  );

  final instructions = TokenInstruction.createAccountAndInitializeMint(
    mint: mint.publicKey,
    mintAuthority: mintAuthority.publicKey,
    freezeAuthority: freezeAuthority,
    rent: rent,
    space: space,
    decimals: decimals,
  );

  return Message(instructions: instructions);
}
