import 'package:solana/src/crypto/ed25519_hd_public_key.dart';
import 'package:solana/src/encoder/account_meta.dart';
import 'package:solana/src/encoder/byte_array.dart';
import 'package:solana/src/encoder/constants.dart';
import 'package:solana/src/encoder/instruction.dart';
import 'package:solana/src/programs/associated_token_account_program/program.dart';
import 'package:solana/src/programs/system_program/program.dart';
import 'package:solana/src/programs/token_program/program.dart';

class AssociatedTokenAccountInstruction extends Instruction {
  /// Create an instruction for the [associated token account][1] program.
  ///
  /// The account will be associated to [mint] and have the associated token
  /// account [address].
  ///
  /// It will be owned by [owner] and funded by [funder].
  ///
  /// The [address] can be derived using `SplToken.computeAssociatedAddress`. It
  /// is required here just to match the spl token program closely in terms of
  /// its API.
  ///
  /// If the [address] does not match the derived address, this method will
  /// fail.
  ///
  /// [1]: https://spl.solana.com/associated-token-account
  factory AssociatedTokenAccountInstruction.createAccount({
    required Ed25519HDPublicKey funder,
    required Ed25519HDPublicKey address,
    required Ed25519HDPublicKey owner,
    required Ed25519HDPublicKey mint,
  }) =>
      AssociatedTokenAccountInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: funder, isSigner: true),
          AccountMeta.writeable(pubKey: address, isSigner: false),
          AccountMeta.readonly(pubKey: owner, isSigner: false),
          AccountMeta.readonly(pubKey: mint, isSigner: false),
          AccountMeta.readonly(
            pubKey: Ed25519HDPublicKey.fromBase58(SystemProgram.programId),
            isSigner: false,
          ),
          AccountMeta.readonly(
            pubKey: Ed25519HDPublicKey.fromBase58(TokenProgram.programId),
            isSigner: false,
          ),
          AccountMeta.readonly(
            pubKey: Ed25519HDPublicKey.fromBase58(Sysvar.rent),
            isSigner: false,
          ),
        ],
      );

  AssociatedTokenAccountInstruction._({
    required super.accounts,
  }) : super(
          programId: AssociatedTokenAccountProgram.id,
          data: const ByteArray.empty(),
        );
}
