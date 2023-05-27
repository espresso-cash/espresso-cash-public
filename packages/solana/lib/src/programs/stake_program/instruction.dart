import 'package:solana/src/crypto/ed25519_hd_public_key.dart';
import 'package:solana/src/encoder/account_meta.dart';
import 'package:solana/src/encoder/byte_array.dart';
import 'package:solana/src/encoder/constants.dart';
import 'package:solana/src/encoder/instruction.dart';
import 'package:solana/src/programs/stake_program/program.dart';
import 'package:solana/src/programs/system_program/instruction.dart';
import 'package:solana/src/rpc/dto/account_data/stake_program/authorized.dart';
import 'package:solana/src/rpc/dto/account_data/stake_program/lockup.dart';

class StakeInstruction extends Instruction {
  StakeInstruction._({
    required super.accounts,
    required super.data,
  }) : super(
          programId: StakeProgram.id,
        );

  /// Initialize a [stake] with lockup and authorization information.
  factory StakeInstruction.initialize({
    required Ed25519HDPublicKey stake,
    required Authorized authorized,
    Lockup lockup = const Lockup.none(),
  }) =>
      StakeInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: stake, isSigner: false),
          AccountMeta.readonly(
            pubKey: Ed25519HDPublicKey.fromBase58(Sysvar.rent),
            isSigner: false,
          ),
        ],
        data: ByteArray.merge([
          StakeProgram.initializeInstructionIndex,
          authorized.serialize(),
          lockup.serialize(),
        ]),
      );

  /// Authorize a key to manage [stake] or withdrawal.
  factory StakeInstruction.authorize({
    required Ed25519HDPublicKey stake,
    required Ed25519HDPublicKey authority,
    required StakeAuthorize authorize,
    Ed25519HDPublicKey? lockupAuthority,
  }) =>
      StakeInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: stake, isSigner: false),
          AccountMeta.readonly(
            pubKey: Ed25519HDPublicKey.fromBase58(Sysvar.clock),
            isSigner: false,
          ),
          AccountMeta.readonly(pubKey: authority, isSigner: true),
          if (lockupAuthority != null)
            AccountMeta.readonly(pubKey: lockupAuthority, isSigner: true),
        ],
        data: ByteArray.merge([
          StakeProgram.authorizeInstructionIndex,
          authorize.serialize(),
        ]),
      );

  /// Delegate a [stake] to a particular [vote] account.
  factory StakeInstruction.delegateStake({
    required Ed25519HDPublicKey stake,
    required Ed25519HDPublicKey vote,
    required Ed25519HDPublicKey config,
    required Ed25519HDPublicKey authority,
  }) =>
      StakeInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: stake, isSigner: false),
          AccountMeta.readonly(pubKey: vote, isSigner: false),
          AccountMeta.readonly(
            pubKey: Ed25519HDPublicKey.fromBase58(Sysvar.clock),
            isSigner: false,
          ),
          AccountMeta.readonly(
            pubKey: Ed25519HDPublicKey.fromBase58(Sysvar.stakeHistory),
            isSigner: false,
          ),
          AccountMeta.readonly(pubKey: config, isSigner: false),
          AccountMeta.readonly(pubKey: authority, isSigner: true),
        ],
        data: StakeProgram.delegateStakeInstructionIndex,
      );

  /// Split tokens [amount] and stake off a [sourceStake] account into
  /// [destinationStake] account.
  factory StakeInstruction.split({
    required Ed25519HDPublicKey sourceStake,
    required Ed25519HDPublicKey destinationStake,
    required Ed25519HDPublicKey authority,
    required int amount,
  }) =>
      StakeInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: sourceStake, isSigner: false),
          AccountMeta.writeable(
            pubKey: destinationStake,
            isSigner: false,
          ),
          AccountMeta.readonly(pubKey: authority, isSigner: true),
        ],
        data: ByteArray.merge([
          StakeProgram.splitInstructionIndex,
          ByteArray.u64(amount),
        ]),
      );

  /// Withdraw unstaked [lamports] from the [stake] account.
  factory StakeInstruction.withdraw({
    required Ed25519HDPublicKey stake,
    required Ed25519HDPublicKey recipient,
    required Ed25519HDPublicKey authority,
    required int lamports,
    Ed25519HDPublicKey? lockupAuthority,
  }) =>
      StakeInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: stake, isSigner: false),
          AccountMeta.writeable(pubKey: recipient, isSigner: false),
          AccountMeta.readonly(
            pubKey: Ed25519HDPublicKey.fromBase58(Sysvar.clock),
            isSigner: false,
          ),
          AccountMeta.readonly(
            pubKey: Ed25519HDPublicKey.fromBase58(Sysvar.stakeHistory),
            isSigner: false,
          ),
          AccountMeta.readonly(
            pubKey: authority,
            isSigner: true,
          ),
          if (lockupAuthority != null)
            AccountMeta.readonly(
              pubKey: lockupAuthority,
              isSigner: true,
            )
        ],
        data: ByteArray.merge([
          StakeProgram.withdrawInstructionIndex,
          ByteArray.u64(lamports),
        ]),
      );

  /// Deactivates the stake in the account.
  factory StakeInstruction.deactivate({
    required Ed25519HDPublicKey stake,
    required Ed25519HDPublicKey authority,
  }) =>
      StakeInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: stake, isSigner: false),
          AccountMeta.readonly(
            pubKey: Ed25519HDPublicKey.fromBase58(Sysvar.clock),
            isSigner: false,
          ),
          AccountMeta.readonly(pubKey: authority, isSigner: true),
        ],
        data: StakeProgram.deactivateInstructionIndex,
      );

  /// Set stake [lockup].
  ///
  /// If a lockup is not active, the withdraw authority may set a new lockup. If
  /// a lockup is active, the lockup custodian may update the lockup parameters.
  factory StakeInstruction.setLockup({
    required Ed25519HDPublicKey stake,
    required Ed25519HDPublicKey authority,
    required Lockup lockup,
  }) =>
      StakeInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: stake, isSigner: false),
          AccountMeta.readonly(pubKey: authority, isSigner: true),
        ],
        data: ByteArray.merge([
          StakeProgram.setLockupInstructionIndex,
          lockup.serialize(),
        ]),
      );

  /// Merge two stake accounts.
  ///
  /// Both accounts must have identical lockup and authority keys. A merge is
  /// possible between two stakes in the following states with no additional
  /// conditions:
  ///
  /// * two deactivated stakes
  /// * an inactive stake into an activating stake during its activation epoch
  ///
  /// For the following cases, the voter pubkey and vote credits observed must
  /// match:
  ///
  /// * two activated stakes
  /// * two activating accounts that share an activation epoch, during the
  ///   activation epoch
  ///
  /// All other combinations of stake states will fail to merge, including all
  /// "transient" states, where a stake is activating or deactivating with a
  /// non-zero effective stake.
  factory StakeInstruction.merge({
    required Ed25519HDPublicKey sourceStake,
    required Ed25519HDPublicKey destinationStake,
    required Ed25519HDPublicKey authority,
  }) =>
      StakeInstruction._(
        accounts: [
          AccountMeta.writeable(
            pubKey: destinationStake,
            isSigner: false,
          ),
          AccountMeta.writeable(pubKey: sourceStake, isSigner: false),
          AccountMeta.readonly(
            pubKey: Ed25519HDPublicKey.fromBase58(Sysvar.clock),
            isSigner: false,
          ),
          AccountMeta.readonly(
            pubKey: Ed25519HDPublicKey.fromBase58(Sysvar.stakeHistory),
            isSigner: false,
          ),
          AccountMeta.readonly(pubKey: authority, isSigner: true),
        ],
        data: StakeProgram.mergeInstructionIndex,
      );

  /// Authorize a key to manage stake or withdrawal with a derived key.
  factory StakeInstruction.authorizeWithSeed({
    required Ed25519HDPublicKey stake,
    required Ed25519HDPublicKey authorityBase,
    required AuthorizeWithSeedArgs args,
    Ed25519HDPublicKey? lockupAuthority,
  }) =>
      StakeInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: stake, isSigner: false),
          AccountMeta.readonly(pubKey: authorityBase, isSigner: true),
          AccountMeta.readonly(
            pubKey: Ed25519HDPublicKey.fromBase58(Sysvar.clock),
            isSigner: false,
          ),
          if (lockupAuthority != null)
            AccountMeta.readonly(
              pubKey: lockupAuthority,
              isSigner: true,
            ),
        ],
        data: ByteArray.merge([
          StakeProgram.authorizeWithSeedInstructionIndex,
          args.serialize(),
        ]),
      );

  /// Initialize a stake with authorization information.
  ///
  /// This instruction is similar to Initialize except that the withdraw
  /// authority must be a signer, and no lockup is applied to the account.
  factory StakeInstruction.initializeChecked({
    required Ed25519HDPublicKey stake,
    required Ed25519HDPublicKey stakeAuthority,
    required Ed25519HDPublicKey withdrawAuthority,
  }) =>
      StakeInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: stake, isSigner: false),
          AccountMeta.readonly(
            pubKey: Ed25519HDPublicKey.fromBase58(Sysvar.rent),
            isSigner: false,
          ),
          AccountMeta.readonly(pubKey: stakeAuthority, isSigner: false),
          AccountMeta.readonly(pubKey: withdrawAuthority, isSigner: true),
        ],
        data: StakeProgram.initializeCheckedInstructionIndex,
      );

  /// Authorize a key to manage stake or withdrawal.
  ///
  /// This instruction behaves like Authorize with the additional requirement
  /// that the new stake or withdraw authority must also be a signer.
  factory StakeInstruction.authorizeChecked({
    required Ed25519HDPublicKey stake,
    required Ed25519HDPublicKey authority,
    required StakeAuthorize stakeAuthorize,
    Ed25519HDPublicKey? lockupAuthority,
  }) =>
      StakeInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: stake, isSigner: false),
          AccountMeta.readonly(
            pubKey: Ed25519HDPublicKey.fromBase58(Sysvar.clock),
            isSigner: false,
          ),
          AccountMeta.readonly(pubKey: authority, isSigner: true),
          AccountMeta.readonly(pubKey: stakeAuthorize.pubKey, isSigner: true),
          if (lockupAuthority != null)
            AccountMeta.readonly(pubKey: lockupAuthority, isSigner: true),
        ],
        data: ByteArray.merge([
          StakeProgram.authorizeCheckedInstructionIndex,
          stakeAuthorize.serialize(),
        ]),
      );

  /// Authorize a key to manage stake or withdrawal with a derived key.
  ///
  /// This instruction behaves like AuthorizeWithSeed with the additional
  /// requirement that the new stake or withdraw authority must also be a
  /// signer.
  factory StakeInstruction.authorizeCheckedWithSeed({
    required Ed25519HDPublicKey stake,
    required Ed25519HDPublicKey base,
    required AuthorizeWithSeedArgs authorizeWithSeedArgs,
    Ed25519HDPublicKey? lockupAuthority,
  }) =>
      StakeInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: stake, isSigner: false),
          AccountMeta.readonly(pubKey: base, isSigner: true),
          AccountMeta.readonly(
            pubKey: Ed25519HDPublicKey.fromBase58(Sysvar.clock),
            isSigner: false,
          ),
          AccountMeta.readonly(
            pubKey: authorizeWithSeedArgs.stakeAuthorize.pubKey,
            isSigner: true,
          ),
          if (lockupAuthority != null)
            AccountMeta.readonly(pubKey: lockupAuthority, isSigner: true),
        ],
        data: ByteArray.merge([
          StakeProgram.authorizeCheckedInstructionIndex,
          authorizeWithSeedArgs.serialize(),
        ]),
      );

  /// Set stake lockup.
  ///
  /// This instruction behaves like `SetLockup` with the additional requirement
  /// that the new lockup authority also be a signer.
  ///
  /// If a lockup is not active, the withdraw authority may set a new lockup If
  /// a lockup is active, the lockup custodian may update the lockup parameters
  factory StakeInstruction.setLockupChecked({
    required Ed25519HDPublicKey stake,
    required Ed25519HDPublicKey authority,
    required LockupCheckedArgs lockupCheckedArgs,
  }) =>
      StakeInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: stake, isSigner: false),
          AccountMeta.writeable(pubKey: authority, isSigner: true),
        ],
        data: ByteArray.merge([
          StakeProgram.setLockupInstructionIndex,
          lockupCheckedArgs.serialize(),
        ]),
      );

  static List<Instruction> createAndInitializeAccount({
    required Ed25519HDPublicKey fundingAccount,
    required Ed25519HDPublicKey newAccount,
    required Authorized authorized,
    required int lamports,
    Lockup lockup = const Lockup.none(),
  }) =>
      [
        SystemInstruction.createAccount(
          newAccount: newAccount,
          fundingAccount: fundingAccount,
          lamports: lamports,
          space: StakeProgram.neededAccountSpace,
          owner: Ed25519HDPublicKey.fromBase58(StakeProgram.programId),
        ),
        StakeInstruction.initialize(
          stake: newAccount,
          authorized: authorized,
          lockup: lockup,
        ),
      ];

  static List<Instruction> createAndInitializeAccountWithSeed({
    required Ed25519HDPublicKey fundingAccount,
    required Ed25519HDPublicKey newAccount,
    required Authorized authorized,
    required Ed25519HDPublicKey base,
    required String seed,
    required int lamports,
    Lockup lockup = const Lockup.none(),
  }) =>
      [
        SystemInstruction.createAccountWithSeed(
          fundingAccount: fundingAccount,
          newAccount: newAccount,
          lamports: lamports,
          space: StakeProgram.neededAccountSpace,
          owner: Ed25519HDPublicKey.fromBase58(StakeProgram.programId),
          seed: seed,
          base: base,
        ),
        StakeInstruction.initialize(
          stake: newAccount,
          authorized: authorized,
          lockup: lockup,
        ),
      ];
}

class LockupCheckedArgs {
  const LockupCheckedArgs({
    required this.unixTimestamp,
    required this.epoch,
  });

  ByteArray serialize() => ByteArray.merge([
        ByteArray.i64(unixTimestamp),
        ByteArray.u64(epoch),
      ]);

  final UnixTimestamp unixTimestamp;
  final Epoch epoch;
}

class AuthorizeWithSeedArgs {
  const AuthorizeWithSeedArgs({
    required this.authorityOwnerPubKey,
    required this.authoritySeed,
    required this.stakeAuthorize,
  });

  ByteArray serialize() => ByteArray.merge([
        stakeAuthorize.serialize(),
        ByteArray.fromString(authoritySeed),
        authorityOwnerPubKey.toByteArray(),
      ]);

  final StakeAuthorize stakeAuthorize;
  final String authoritySeed;
  final Ed25519HDPublicKey authorityOwnerPubKey;
}
