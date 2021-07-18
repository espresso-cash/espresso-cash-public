import 'package:solana/src/encoder/account_meta.dart';
import 'package:solana/src/encoder/buffer.dart';
import 'package:solana/src/encoder/constants.dart';
import 'package:solana/src/encoder/instruction.dart';
import 'package:solana/src/token_program/token_program.dart';

/// A spl token program instruction.
class TokenInstruction extends Instruction {
  const TokenInstruction._({
    required List<AccountMeta> accounts,
    required Iterable<int> data,
  }) : super(
          programId: TokenProgram.programId,
          accounts: accounts,
          data: data,
        );

  /// Construct an instruction to initialize a new spl token with address [mint],
  /// [decimals] decimal places, and [mintAuthority] as the mint authority.
  ///
  /// You can use [RPCClient.getMinimumBalanceForRentExemption]
  /// to determine [rent] for the required [space].
  ///
  /// The [freezeAuthority] is optional and can be used to specify a the
  /// freeze authority for this token.
  factory TokenInstruction.initializeMint({
    required String mint,
    required String mintAuthority,
    required int decimals,
    String? freezeAuthority,
  }) =>
      TokenInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: mint, isSigner: false),
          AccountMeta.readonly(pubKey: Sysvar.rent, isSigner: false),
        ],
        data: Buffer.fromConcatenatedByteArrays([
          TokenProgram.initializeMintInstructionIndex,
          Buffer.fromUint8(decimals),
          Buffer.fromBase58(mintAuthority),
          Buffer.fromUint8(freezeAuthority != null ? 1 : 0),
          if (freezeAuthority != null)
            Buffer.fromBase58(freezeAuthority)
          else
            List<int>.filled(32, 0),
        ]),
      );

  /// Construct an instruction to initialize a new account for the token [mint].
  ///
  /// The new account [address] must be created using the corresponding system
  /// instruction.
  ///
  /// When you include this instruction in a transaction, then the transaction must
  /// be signed by [owner] and [address].
  factory TokenInstruction.initializeAccount({
    required String mint,
    required String address,
    required String owner,
  }) =>
      TokenInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: address, isSigner: true),
          AccountMeta.readonly(pubKey: mint, isSigner: false),
          AccountMeta.readonly(pubKey: owner, isSigner: false),
          AccountMeta.readonly(pubKey: Sysvar.rent, isSigner: false),
        ],
        data: TokenProgram.initializeAccountInstructionIndex,
      );

  factory TokenInstruction.transfer({
    required String source,
    required String destination,
    required String owner,
    required int amount,
  }) =>
      TokenInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: source, isSigner: false),
          AccountMeta.writeable(pubKey: destination, isSigner: false),
          // TODO(IA): this should be readonly unless, it is the fee payer
          AccountMeta.writeable(pubKey: owner, isSigner: true),
        ],
        data: Buffer.fromConcatenatedByteArrays([
          TokenProgram.transferInstructionIndex,
          Buffer.fromUint64(amount),
        ]),
      );

  /// Mint the [destination] account with [amount] tokens of the [mint] token.
  /// The [authority] is the mint authority of the token.
  ///
  /// The [destination] account must exist and be linked with [mint]. You can create
  /// it by using [TokenProgram.createAccount].
  factory TokenInstruction.mintTo({
    required String mint,
    required String destination,
    required String authority,
    required int amount,
  }) =>
      TokenInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: mint, isSigner: false),
          AccountMeta.writeable(pubKey: destination, isSigner: false),
          // TODO(IA): this should be readonly unless, it is the fee payer
          AccountMeta.writeable(pubKey: authority, isSigner: true),
        ],
        data: Buffer.fromConcatenatedByteArrays([
          TokenProgram.mintToInstructionIndex,
          Buffer.fromUint64(amount),
        ]),
      );
}
