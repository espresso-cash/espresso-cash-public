import 'package:solana/src/common/byte_array.dart';
import 'package:solana/src/crypto/ed25519_hd_public_key.dart';
import 'package:solana/src/encoder/account_meta.dart';
import 'package:solana/src/encoder/buffer.dart';
import 'package:solana/src/encoder/constants.dart';
import 'package:solana/src/encoder/instruction.dart';
import 'package:solana/src/programs/system_program/system_program.dart';

class SystemInstruction extends Instruction {
  /// Create a system program instruction with [data], for [accounts].
  ///
  /// Since [accounts] is interpreted by the specific program that will be
  /// called, then it's the responsibility of the caller to pass the array
  /// correctly sorted, e.g., for a transfer program the `source` should be
  /// before the `destination`
  SystemInstruction._({
    required List<AccountMeta> accounts,
    required ByteArray data,
  }) : super(
          programId: SystemProgram.id,
          accounts: accounts,
          data: data,
        );

  /// Create account.
  ///
  /// The [pubKey] is the public key of the new account [owner] as its owner.
  /// The [owner] is the funder of the account.
  ///
  /// For the [lamports] you must call
  /// [RPCClient.getMinimumBalanceForRentExemption()] and proved the [space] you
  /// want to allocate for the account.
  ///
  /// The account will be linked to the [programId] program.
  ///
  /// If [pubKey] is the [owner]'s address, and the owner has tokens this will
  /// fail because the account would already exist.
  factory SystemInstruction.createAccount({
    required Ed25519HDPublicKey fromPubKey,
    required Ed25519HDPublicKey pubKey,
    required int lamports,
    required int space,
    required Ed25519HDPublicKey owner,
  }) =>
      SystemInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: fromPubKey, isSigner: true),
          AccountMeta.writeable(pubKey: pubKey, isSigner: true),
        ],
        data: Buffer.fromConcatenatedByteArrays([
          SystemProgram.createAccountInstructionIndex,
          Buffer.fromUint64(lamports),
          Buffer.fromUint64(space),
          owner.toBuffer(),
        ]),
      );

  /// Assign account to a program.
  ///
  /// Assign [pubKey] account to [owner] program.
  factory SystemInstruction.assign({
    required Ed25519HDPublicKey pubKey,
    required Ed25519HDPublicKey owner,
  }) =>
      SystemInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: pubKey, isSigner: true),
        ],
        data: Buffer.fromConcatenatedByteArrays([
          SystemProgram.assignInstructionIndex,
          owner.toBuffer(),
        ]),
      );

  /// Transfer lamports.
  ///
  /// The instruction would send [lamports] from [source] to [destination].
  factory SystemInstruction.transfer({
    required Ed25519HDPublicKey source,
    required Ed25519HDPublicKey destination,
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

  /// Create a new account at an address derived from a [base] pubkey and
  /// [seed].
  factory SystemInstruction.createAccountWithSeed({
    required Ed25519HDPublicKey fromPubKey,
    required Ed25519HDPublicKey pubKey,
    required Ed25519HDPublicKey base,
    required String seed,
    required int lamports,
    required int space,
    required Ed25519HDPublicKey owner,
  }) =>
      SystemInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: fromPubKey, isSigner: true),
          AccountMeta.writeable(pubKey: pubKey, isSigner: false),
          AccountMeta.readonly(pubKey: base, isSigner: true),
        ],
        data: Buffer.fromConcatenatedByteArrays([
          SystemProgram.createAccountWithSeedInstructionIndex,
          base.toBuffer(),
          Buffer.fromString(seed),
          Buffer.fromUint64(lamports),
          Buffer.fromUint64(space),
          owner.toBuffer(),
        ]),
      );

  factory SystemInstruction.advanceNonceAccount({
    required Ed25519HDPublicKey noncePubKey,
    required Ed25519HDPublicKey nonceAuthorityPubKey,
  }) =>
      SystemInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: noncePubKey, isSigner: false),
          AccountMeta.writeable(
            pubKey: Ed25519HDPublicKey.fromBase58(Sysvar.recentBlockHashes),
            isSigner: false,
          ),
          AccountMeta.writeable(pubKey: nonceAuthorityPubKey, isSigner: true),
        ],
        data: SystemProgram.advanceNonceAccountInstructionIndex,
      );

  factory SystemInstruction.withdrawNonceAccount({
    required Ed25519HDPublicKey noncePubKey,
    required Ed25519HDPublicKey authorizedPubKey,
    required Ed25519HDPublicKey toPubKey,
    required int lamports,
  }) =>
      SystemInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: noncePubKey, isSigner: false),
          AccountMeta.writeable(pubKey: toPubKey, isSigner: false),
          AccountMeta.readonly(
            pubKey: Ed25519HDPublicKey.fromBase58(Sysvar.recentBlockHashes),
            isSigner: false,
          ),
          AccountMeta.readonly(
            pubKey: Ed25519HDPublicKey.fromBase58(Sysvar.rent),
            isSigner: false,
          ),
          AccountMeta.readonly(pubKey: authorizedPubKey, isSigner: true),
        ],
        data: Buffer.fromConcatenatedByteArrays([
          SystemProgram.withdrawNonceAccountInstructionIndex,
          Buffer.fromUint64(lamports),
        ]),
      );

  factory SystemInstruction.initializeNonceAccount({
    required Ed25519HDPublicKey noncePubKey,
    required Ed25519HDPublicKey authority,
  }) =>
      SystemInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: noncePubKey, isSigner: false),
          AccountMeta.readonly(
            pubKey: Ed25519HDPublicKey.fromBase58(Sysvar.recentBlockHashes),
            isSigner: false,
          ),
          AccountMeta.readonly(
            pubKey: Ed25519HDPublicKey.fromBase58(Sysvar.rent),
            isSigner: false,
          ),
        ],
        data: Buffer.fromConcatenatedByteArrays([
          SystemProgram.initializeNonceAccountInstructionIndex,
          authority.toBuffer(),
        ]),
      );

  factory SystemInstruction.authorizeNonceAccount({
    required Ed25519HDPublicKey noncePubKey,
    required Ed25519HDPublicKey authorizedPubKey,
    required Ed25519HDPublicKey newAuthority,
  }) =>
      SystemInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: noncePubKey, isSigner: false),
          AccountMeta.readonly(pubKey: authorizedPubKey, isSigner: true),
        ],
        data: Buffer.fromConcatenatedByteArrays([
          SystemProgram.authorizeNonceAccountInstructionIndex,
          newAuthority.toBuffer(),
        ]),
      );

  factory SystemInstruction.allocate({
    required Ed25519HDPublicKey pubKey,
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
    required Ed25519HDPublicKey pubKey,
    required Ed25519HDPublicKey base,
    required String seed,
    required int space,
    required Ed25519HDPublicKey owner,
  }) =>
      SystemInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: pubKey, isSigner: false),
          AccountMeta.writeable(pubKey: base, isSigner: true),
        ],
        data: Buffer.fromConcatenatedByteArrays([
          SystemProgram.allocateWithSeedInstructionIndex,
          base.toBuffer(),
          Buffer.fromString(seed),
          Buffer.fromUint64(space),
          owner.toBuffer(),
        ]),
      );

  factory SystemInstruction.assignWithSeed({
    required Ed25519HDPublicKey pubKey,
    required Ed25519HDPublicKey base,
    required String seed,
    required Ed25519HDPublicKey owner,
  }) =>
      SystemInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: pubKey, isSigner: false),
          AccountMeta.readonly(pubKey: base, isSigner: true),
        ],
        data: Buffer.fromConcatenatedByteArrays([
          SystemProgram.assignWithSeedInstructionIndex,
          base.toBuffer(),
          Buffer.fromString(seed),
          owner.toBuffer(),
        ]),
      );

  factory SystemInstruction.transferWithSeed({
    required Ed25519HDPublicKey source,
    required Ed25519HDPublicKey base,
    required String seed,
    required Ed25519HDPublicKey owner,
    required Ed25519HDPublicKey destination,
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
          owner.toBuffer(),
        ]),
      );

  static List<Instruction> createNonceAccount({
    required Ed25519HDPublicKey fromPubKey,
    required Ed25519HDPublicKey noncePubKey,
    required Ed25519HDPublicKey noceAuthorityPubKey,
    required int lamports,
  }) =>
      [
        SystemInstruction.createAccount(
          fromPubKey: fromPubKey,
          pubKey: noncePubKey,
          lamports: lamports,
          space: SystemProgram.nonceAccountSize,
          owner: Ed25519HDPublicKey.fromBase58(SystemProgram.programId),
        ),
        SystemInstruction.initializeNonceAccount(
          noncePubKey: noncePubKey,
          authority: noceAuthorityPubKey,
        )
      ];
}
