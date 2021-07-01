import 'package:solana/src/common/byte_array.dart';
import 'package:solana/src/encoder/account_meta.dart';
import 'package:solana/src/encoder/buffer.dart';
import 'package:solana/src/encoder/instruction.dart';
import 'package:solana/src/system_program/system_program.dart';

class SystemInstruction extends Instruction {
  /// Create a system program instruction with [data], for [accounts].
  ///
  /// Since [accounts] is interpreted by the specific program that will
  /// be called, then it's the responsibility of the caller to pass the
  /// array correctly sorted, e.g., for a transfer program the `source` should
  /// be before the `destination`
  const SystemInstruction({
    required List<AccountMeta> accounts,
    required ByteArray data,
  }) : super(
          programId: SystemProgram.programId,
          accounts: accounts,
          data: data,
        );

  /// Construct transfer instruction of the [SystemProgram].
  ///
  /// The instruction would send [lamports] from [source] to [destination].
  factory SystemInstruction.transfer({
    required String source,
    required String destination,
    required int lamports,
  }) =>
      SystemInstruction(
        accounts: [
          AccountMeta.writeable(pubKey: source, isSigner: true),
          AccountMeta.writeable(pubKey: destination, isSigner: false),
        ],
        data: Buffer.fromConcatenatedByteArrays([
          SystemProgram.transferInstructionIndex,
          Buffer.fromInt64(lamports),
        ]),
      );

  /// Construct a create account instruction of the [SystemProgram].
  ///
  /// The [address] is the public key of the new account
  /// [owner] as its owner. The [owner] is the funder of the account.
  ///
  /// For the [rent] you must call [RPCClient.getMinimumBalanceForRentExemption()]
  /// and proved the [space] you want to allocate for the account.
  ///
  /// The account will be linked to the [programId] program.
  ///
  /// If [address] is the [owner]'s address, and the owner has tokens this will
  /// fail because the account would already exist.
  factory SystemInstruction.createAccount({
    required String address,
    required String owner,
    required int rent,
    required int space,
    required String programId,
  }) =>
      SystemInstruction(
        accounts: [
          AccountMeta.writeable(pubKey: owner, isSigner: true),
          AccountMeta.writeable(pubKey: address, isSigner: true),
        ],
        data: Buffer.fromConcatenatedByteArrays([
          SystemProgram.createAccountInstructionIndex,
          Buffer.fromUint64(rent),
          Buffer.fromUint64(space),
          Buffer.fromBase58(programId),
        ]),
      );
}
