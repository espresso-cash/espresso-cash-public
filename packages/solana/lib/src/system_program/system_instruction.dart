import 'package:solana/src/common/byte_array.dart';
import 'package:solana/src/encoder/account_meta.dart';
import 'package:solana/src/encoder/buffer.dart';
import 'package:solana/src/encoder/constants.dart';
import 'package:solana/src/encoder/instruction.dart';
import 'package:solana/src/system_program/system_program.dart';

class SystemInstruction extends Instruction {
  /// Create a system program instruction with [data], for [accounts].
  ///
  /// Since [accounts] is interpreted by the specific program that will
  /// be called, then it's the responsibility of the caller to pass the
  /// array correctly sorted, e.g., for a transfer program the `source` should
  /// be before the `destination`
  const SystemInstruction._({
    required List<AccountMeta> accounts,
    required ByteArray data,
  }) : super(
          programId: SystemProgram.programId,
          accounts: accounts,
          data: data,
        );

  /// Create account.
  ///
  /// The [address] is the public key of the new account
  /// [owner] as its owner. The [owner] is the funder of the account.
  ///
  /// For the [lamports] you must call [RPCClient.getMinimumBalanceForRentExemption()]
  /// and proved the [space] you want to allocate for the account.
  ///
  /// The account will be linked to the [programId] program.
  ///
  /// If [address] is the [owner]'s address, and the owner has tokens this will
  /// fail because the account would already exist.
  factory SystemInstruction.createAccount({
    required String creator,
    required String address,
    required int lamports,
    required int space,
    required String owner,
  }) =>
      SystemInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: creator, isSigner: true),
          AccountMeta.writeable(pubKey: address, isSigner: true),
        ],
        data: Buffer.fromConcatenatedByteArrays([
          SystemProgram.createAccountInstructionIndex,
          Buffer.fromUint64(lamports),
          Buffer.fromUint64(space),
          Buffer.fromBase58(owner),
        ]),
      );

  /// Assign account to a program.
  ///
  /// Assign [pubKey] account to [owner] program
  factory SystemInstruction.assign({
    required String pubKey,
    required String owner,
  }) =>
      SystemInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: pubKey, isSigner: true),
        ],
        data: Buffer.fromConcatenatedByteArrays([
          SystemProgram.assignInstructionIndex,
          Buffer.fromBase58(owner),
        ]),
      );

  /// Transfer lamports
  ///
  /// The instruction would send [lamports] from [source] to [destination].
  factory SystemInstruction.transfer({
    required String source,
    required String destination,
    required int lamports,
  }) =>
      SystemInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: source, isSigner: true),
          AccountMeta.writeable(pubKey: destination, isSigner: false),
        ],
        data: Buffer.fromConcatenatedByteArrays([
          SystemProgram.transferInstructionIndex,
          Buffer.fromInt64(lamports),
        ]),
      );

  /// Create a new account at an address derived from a [base] pubkey and [seed]
  factory SystemInstruction.createAccountWithSeed({
    required String creator,
    required String address,
    required String base,
    required String seed,
    required int lamports,
    required int space,
    required String owner,
  }) =>
      SystemInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: creator, isSigner: true),
          AccountMeta.writeable(pubKey: address, isSigner: true),
          AccountMeta.readonly(pubKey: base, isSigner: false),
        ],
        data: Buffer.fromConcatenatedByteArrays([
          SystemProgram.createAccountWithSeedInstructionIndex,
          Buffer.fromBase58(base),
          Buffer.fromString(seed),
          Buffer.fromUint64(lamports),
          Buffer.fromUint64(space),
          Buffer.fromBase58(owner),
        ]),
      );

  factory SystemInstruction.advanceNonceAccount({
    required String noncePubKey,
    required String authorizedPubKey,
  }) =>
      SystemInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: noncePubKey, isSigner: false),
          AccountMeta.writeable(
            pubKey: Sysvar.recentBlockHashes,
            isSigner: false,
          ),
          AccountMeta.writeable(pubKey: authorizedPubKey, isSigner: true),
        ],
        data: Buffer.fromConcatenatedByteArrays([
          SystemProgram.advanceNonceAccountInstructionIndex,
        ]),
      );

  factory SystemInstruction.withdrawNonceAccount({
    required String noncePubKey,
    required String authorizedPubKey,
    required String toPubKey,
    required int lamports,
  }) =>
      SystemInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: noncePubKey, isSigner: false),
          AccountMeta.writeable(pubKey: toPubKey, isSigner: false),
          AccountMeta.readonly(
            pubKey: Sysvar.recentBlockHashes,
            isSigner: false,
          ),
          AccountMeta.readonly(pubKey: Sysvar.rent, isSigner: false),
          AccountMeta.readonly(pubKey: authorizedPubKey, isSigner: true),
        ],
        data: Buffer.fromConcatenatedByteArrays([
          SystemProgram.withdrawNonceAccountInstructionIndex,
          Buffer.fromUint64(lamports),
        ]),
      );

  factory SystemInstruction.initializeNonceAccount({
    required String noncePubKey,
    required String authority,
  }) =>
      SystemInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: noncePubKey, isSigner: false),
          AccountMeta.readonly(
              pubKey: Sysvar.recentBlockHashes, isSigner: false),
          AccountMeta.readonly(pubKey: Sysvar.rent, isSigner: false),
        ],
        data: Buffer.fromConcatenatedByteArrays([
          SystemProgram.initializeNonceAccountInstructionIndex,
          Buffer.fromBase58(authority),
        ]),
      );

  factory SystemInstruction.authorizeNonceAccount({
    required String noncePubKey,
    required String authorizedPubKey,
    required String newAuthority,
  }) =>
      SystemInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: noncePubKey, isSigner: false),
          AccountMeta.readonly(pubKey: authorizedPubKey, isSigner: true),
        ],
        data: Buffer.fromConcatenatedByteArrays([
          SystemProgram.authorizeNonceAccountInstructionIndex,
          Buffer.fromBase58(newAuthority),
        ]),
      );

  factory SystemInstruction.allocate({
    required String pubKey,
    required int space,
  }) =>
      SystemInstruction._(
        accounts: [AccountMeta.writeable(pubKey: pubKey, isSigner: true)],
        data: Buffer.fromConcatenatedByteArrays([
          SystemProgram.allocateInstructionIndex,
          Buffer.fromUint64(space),
        ]),
      );

  factory SystemInstruction.allocateWithSeed({
    required String address,
    required String base,
    required String seed,
    required int space,
    required String owner,
  }) =>
      SystemInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: address, isSigner: false),
          AccountMeta.writeable(pubKey: base, isSigner: true),
        ],
        data: Buffer.fromConcatenatedByteArrays([
          SystemProgram.allocateWithSeedInstructionIndex,
          Buffer.fromBase58(base),
          Buffer.fromString(seed),
          Buffer.fromUint64(space),
          Buffer.fromBase58(owner),
        ]),
      );

  factory SystemInstruction.assignWithSeed({
    required String address,
    required String base,
    required String seed,
    required String owner,
  }) =>
      SystemInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: address, isSigner: false),
          AccountMeta.readonly(pubKey: base, isSigner: true),
        ],
        data: Buffer.fromConcatenatedByteArrays([
          SystemProgram.assignWithSeedInstructionIndex,
          Buffer.fromString(seed),
          Buffer.fromBase58(owner),
        ]),
      );

  factory SystemInstruction.transferWithSeed({
    required String source,
    required String base,
    required String seed,
    required String owner,
    required String destination,
    required int lamports,
  }) =>
      SystemInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: source, isSigner: false),
          AccountMeta.readonly(pubKey: base, isSigner: true),
          AccountMeta.writeable(pubKey: destination, isSigner: false),
        ],
        data: Buffer.fromConcatenatedByteArrays([
          SystemProgram.transferWithSeedInstructionIndex,
          Buffer.fromUint64(lamports),
          Buffer.fromString(seed),
          Buffer.fromBase58(owner),
        ]),
      );
}
