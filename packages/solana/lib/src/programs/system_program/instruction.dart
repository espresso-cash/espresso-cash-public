import 'package:solana/src/common/byte_array.dart';
import 'package:solana/src/crypto/ed25519_hd_public_key.dart';
import 'package:solana/src/encoder/account_meta.dart';
import 'package:solana/src/encoder/buffer.dart';
import 'package:solana/src/encoder/constants.dart';
import 'package:solana/src/encoder/instruction.dart';
import 'package:solana/src/programs/system_program/program.dart';

/// Create new accounts, allocate account data, assign accounts to owning
/// programs, transfer lamports from System Program owned accounts and pay
/// transaction fees.
class SystemInstruction extends Instruction {
  SystemInstruction._({
    required List<AccountMeta> accounts,
    required ByteArray data,
  }) : super(
          programId: SystemProgram.id,
          accounts: accounts,
          data: data,
        );

  /// Create a new account.
  ///
  /// Number or [lamports] will be transferred from [fundingAccount] to
  /// [newAccount], and amount of [space] in bytes will be allocated.
  ///
  /// [owner] is the address of program that will own the [newAccount].
  factory SystemInstruction.createAccount({
    required Ed25519HDPublicKey fundingAccount,
    required Ed25519HDPublicKey newAccount,
    required int lamports,
    required int space,
    required Ed25519HDPublicKey owner,
  }) =>
      SystemInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: fundingAccount, isSigner: true),
          AccountMeta.writeable(pubKey: newAccount, isSigner: true),
        ],
        data: Buffer.fromConcatenatedByteArrays([
          SystemProgram.createAccountInstructionIndex,
          Buffer.fromUint64(lamports),
          Buffer.fromUint64(space),
          owner.toBuffer(),
        ]),
      );

  /// Assign account [assignedAccount] to a program [owner].
  factory SystemInstruction.assign({
    required Ed25519HDPublicKey assignedAccount,
    required Ed25519HDPublicKey owner,
  }) =>
      SystemInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: assignedAccount, isSigner: true),
        ],
        data: Buffer.fromConcatenatedByteArrays([
          SystemProgram.assignInstructionIndex,
          owner.toBuffer(),
        ]),
      );

  /// Transfer [lamports] from [fundingAccount] to [recipientAccount].
  factory SystemInstruction.transfer({
    required Ed25519HDPublicKey fundingAccount,
    required Ed25519HDPublicKey recipientAccount,
    required int lamports,
  }) =>
      SystemInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: fundingAccount, isSigner: true),
          AccountMeta.writeable(pubKey: recipientAccount, isSigner: false),
        ],
        data: Buffer.fromConcatenatedByteArrays([
          SystemProgram.transferInstructionIndex,
          Buffer.fromInt64(lamports),
        ]),
      );

  /// Create a new account at an address derived from a [base] pubkey and
  /// a [seed].
  factory SystemInstruction.createAccountWithSeed({
    required Ed25519HDPublicKey fundingAccount,
    required Ed25519HDPublicKey newAccount,
    required Ed25519HDPublicKey base,
    required String seed,
    required int lamports,
    required int space,
    required Ed25519HDPublicKey owner,
  }) =>
      SystemInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: fundingAccount, isSigner: true),
          AccountMeta.writeable(pubKey: newAccount, isSigner: false),
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

  /// Consumes a stored [nonce], replacing it with a successor.
  factory SystemInstruction.advanceNonceAccount({
    required Ed25519HDPublicKey nonce,
    required Ed25519HDPublicKey nonceAuthority,
  }) =>
      SystemInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: nonce, isSigner: false),
          AccountMeta.writeable(
            pubKey: Ed25519HDPublicKey.fromBase58(Sysvar.recentBlockHashes),
            isSigner: false,
          ),
          AccountMeta.writeable(pubKey: nonceAuthority, isSigner: true),
        ],
        data: SystemProgram.advanceNonceAccountInstructionIndex,
      );

  /// Withdraw funds from a [nonce] account.
  factory SystemInstruction.withdrawNonceAccount({
    required Ed25519HDPublicKey nonce,
    required Ed25519HDPublicKey nonceAuthority,
    required Ed25519HDPublicKey recipient,
    required int lamports,
  }) =>
      SystemInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: nonce, isSigner: false),
          AccountMeta.writeable(pubKey: recipient, isSigner: false),
          AccountMeta.readonly(
            pubKey: Ed25519HDPublicKey.fromBase58(Sysvar.recentBlockHashes),
            isSigner: false,
          ),
          AccountMeta.readonly(
            pubKey: Ed25519HDPublicKey.fromBase58(Sysvar.rent),
            isSigner: false,
          ),
          AccountMeta.readonly(pubKey: nonceAuthority, isSigner: true),
        ],
        data: Buffer.fromConcatenatedByteArrays([
          SystemProgram.withdrawNonceAccountInstructionIndex,
          Buffer.fromUint64(lamports),
        ]),
      );

  /// Drive state of Uninitialized [nonce] account to Initialized, setting the
  /// nonce value.
  factory SystemInstruction.initializeNonceAccount({
    required Ed25519HDPublicKey nonce,
    required Ed25519HDPublicKey nonceAuthority,
  }) =>
      SystemInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: nonce, isSigner: false),
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
          nonceAuthority.toBuffer(),
        ]),
      );

  /// Change the entity authorized to execute nonce instructions on the account.
  factory SystemInstruction.authorizeNonceAccount({
    required Ed25519HDPublicKey nonce,
    required Ed25519HDPublicKey nonceAuthority,
    required Ed25519HDPublicKey newAuthority,
  }) =>
      SystemInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: nonce, isSigner: false),
          AccountMeta.readonly(pubKey: nonceAuthority, isSigner: true),
        ],
        data: Buffer.fromConcatenatedByteArrays([
          SystemProgram.authorizeNonceAccountInstructionIndex,
          newAuthority.toBuffer(),
        ]),
      );

  /// Allocate [space] in a (possibly new) [account] without funding.
  factory SystemInstruction.allocate({
    required Ed25519HDPublicKey account,
    required int space,
  }) =>
      SystemInstruction._(
        accounts: [AccountMeta.writeable(pubKey: account, isSigner: true)],
        data: Buffer.fromConcatenatedByteArrays([
          SystemProgram.allocateInstructionIndex,
          Buffer.fromUint64(space),
        ]),
      );

  /// Allocate [space] for and assign an [account] at an address derived from a
  /// [base] public key and a [seed].
  factory SystemInstruction.allocateWithSeed({
    required Ed25519HDPublicKey account,
    required Ed25519HDPublicKey base,
    required String seed,
    required int space,
    required Ed25519HDPublicKey owner,
  }) =>
      SystemInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: account, isSigner: false),
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

  /// Assign [account] to a program based on a [seed].
  factory SystemInstruction.assignWithSeed({
    required Ed25519HDPublicKey account,
    required Ed25519HDPublicKey base,
    required String seed,
    required Ed25519HDPublicKey owner,
  }) =>
      SystemInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: account, isSigner: false),
          AccountMeta.readonly(pubKey: base, isSigner: true),
        ],
        data: Buffer.fromConcatenatedByteArrays([
          SystemProgram.assignWithSeedInstructionIndex,
          base.toBuffer(),
          Buffer.fromString(seed),
          owner.toBuffer(),
        ]),
      );

  /// Transfer [lamports] from a derived address.
  factory SystemInstruction.transferWithSeed({
    required Ed25519HDPublicKey fundingAccount,
    required Ed25519HDPublicKey base,
    required String seed,
    required Ed25519HDPublicKey owner,
    required Ed25519HDPublicKey recipientAccount,
    required int lamports,
  }) =>
      SystemInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: fundingAccount, isSigner: false),
          AccountMeta.readonly(pubKey: base, isSigner: true),
          AccountMeta.writeable(pubKey: recipientAccount, isSigner: false),
        ],
        data: Buffer.fromConcatenatedByteArrays([
          SystemProgram.transferWithSeedInstructionIndex,
          Buffer.fromUint64(lamports),
          Buffer.fromString(seed),
          owner.toBuffer(),
        ]),
      );

  static List<Instruction> createAndInitializeNonceAccount({
    required Ed25519HDPublicKey fromPubKey,
    required Ed25519HDPublicKey noncePubKey,
    required Ed25519HDPublicKey noceAuthorityPubKey,
    required int lamports,
  }) =>
      [
        SystemInstruction.createAccount(
          fundingAccount: fromPubKey,
          newAccount: noncePubKey,
          lamports: lamports,
          space: SystemProgram.nonceAccountSize,
          owner: Ed25519HDPublicKey.fromBase58(SystemProgram.programId),
        ),
        SystemInstruction.initializeNonceAccount(
          nonce: noncePubKey,
          nonceAuthority: noceAuthorityPubKey,
        )
      ];
}
