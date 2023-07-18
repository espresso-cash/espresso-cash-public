import 'package:solana/src/crypto/ed25519_hd_public_key.dart';
import 'package:solana/src/encoder/account_meta.dart';
import 'package:solana/src/encoder/byte_array.dart';
import 'package:solana/src/encoder/constants.dart';
import 'package:solana/src/encoder/instruction.dart';
import 'package:solana/src/programs/system_program/program.dart';

/// Create new accounts, allocate account data, assign accounts to owning
/// programs, transfer lamports from System Program owned accounts and pay
/// transaction fees.
class SystemInstruction extends Instruction {
  SystemInstruction._({
    required super.accounts,
    required super.data,
  }) : super(
          programId: SystemProgram.id,
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
        data: ByteArray.merge([
          SystemProgram.createAccountInstructionIndex,
          ByteArray.u64(lamports),
          ByteArray.u64(space),
          owner.toByteArray(),
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
        data: ByteArray.merge([
          SystemProgram.assignInstructionIndex,
          owner.toByteArray(),
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
        data: ByteArray.merge([
          SystemProgram.transferInstructionIndex,
          ByteArray.u64(lamports),
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
        data: ByteArray.merge([
          SystemProgram.createAccountWithSeedInstructionIndex,
          base.toByteArray(),
          ByteArray.fromString(seed),
          ByteArray.u64(lamports),
          ByteArray.u64(space),
          owner.toByteArray(),
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
        data: ByteArray.merge([
          SystemProgram.withdrawNonceAccountInstructionIndex,
          ByteArray.u64(lamports),
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
        data: ByteArray.merge([
          SystemProgram.initializeNonceAccountInstructionIndex,
          nonceAuthority.toByteArray(),
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
        data: ByteArray.merge([
          SystemProgram.authorizeNonceAccountInstructionIndex,
          newAuthority.toByteArray(),
        ]),
      );

  /// Allocate [space] in a (possibly new) [account] without funding.
  factory SystemInstruction.allocate({
    required Ed25519HDPublicKey account,
    required int space,
  }) =>
      SystemInstruction._(
        accounts: [AccountMeta.writeable(pubKey: account, isSigner: true)],
        data: ByteArray.merge([
          SystemProgram.allocateInstructionIndex,
          ByteArray.u64(space),
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
        data: ByteArray.merge([
          SystemProgram.allocateWithSeedInstructionIndex,
          base.toByteArray(),
          ByteArray.fromString(seed),
          ByteArray.u64(space),
          owner.toByteArray(),
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
        data: ByteArray.merge([
          SystemProgram.assignWithSeedInstructionIndex,
          base.toByteArray(),
          ByteArray.fromString(seed),
          owner.toByteArray(),
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
        data: ByteArray.merge([
          SystemProgram.transferWithSeedInstructionIndex,
          ByteArray.u64(lamports),
          ByteArray.fromString(seed),
          owner.toByteArray(),
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
