import 'package:solana/src/common/byte_array.dart';
import 'package:solana/src/encoder/account_meta.dart';
import 'package:solana/src/encoder/buffer.dart';
import 'package:solana/src/encoder/constants.dart';
import 'package:solana/src/encoder/instruction.dart';
import 'package:solana/src/programs/stake_program/stake_program.dart';
import 'package:solana/src/programs/stake_program/state.dart';

class StakeInstruction extends Instruction {
  StakeInstruction._({
    required List<AccountMeta> accounts,
    required ByteArray data,
  }) : super(
          programId: StakeProgram.programId,
          accounts: accounts,
          data: data,
        );

  /// Initialize a stake with lockup and authorization information
  ///
  /// # Account references
  ///   0. [stakePubKey] `[WRITE]` Uninitialized stake account
  ///   1. `[]` Rent sysvar
  ///
  /// [authorized ]carries public keys that must sign staker transactions
  ///   and withdrawer transactions.
  /// [lockup] carries information about withdrawal restrictions
  factory StakeInstruction.initialize({
    required String stakePubKey,
    required Authorized authorized,
    Lockup lockup = const Lockup.none(),
  }) =>
      StakeInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: stakePubKey, isSigner: false),
          AccountMeta.readonly(pubKey: Sysvar.rent, isSigner: false),
        ],
        data: Buffer.fromConcatenatedByteArrays([
          StakeProgram.initializeInstructionIndex,
          authorized.serialize(),
          lockup.serialize(),
        ]),
      );

  /// Authorize a [stakeAuthorize] to manage stake or withdrawal
  ///
  /// # Account references
  ///   0. [stakePubKey] `[WRITE]` Stake account to be updated
  ///   1. `[]` Clock sysvar
  ///   2. [authorityPubKey] `[SIGNER]` The stake or withdraw authority
  ///   3. [lockupAuthorityPubKey] Optional: `[SIGNER]` Lockup authority, if updating StakeAuthorize::Withdrawer before
  ///      lockup expiration
  factory StakeInstruction.authorize({
    required String stakePubKey,
    required String authorityPubKey,
    required StakeAuthorize stakeAuthorize,
    String? lockupAuthorityPubKey,
  }) =>
      StakeInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: stakePubKey, isSigner: false),
          AccountMeta.readonly(pubKey: Sysvar.clock, isSigner: false),
          AccountMeta.readonly(pubKey: authorityPubKey, isSigner: true),
          if (lockupAuthorityPubKey != null)
            AccountMeta.readonly(pubKey: lockupAuthorityPubKey, isSigner: true),
        ],
        data: Buffer.fromConcatenatedByteArrays([
          StakeProgram.authorizeInstructionIndex,
          stakeAuthorize.serialize(),
        ]),
      );

  /// Delegate a stake to a particular vote account
  ///
  /// # Account references
  ///   0. [stakePubKey] `[WRITE]` Initialized stake account to be delegated
  ///   1. [votePubKey] `[]` Vote account to which this stake will be delegated
  ///   2. `[]` Clock sysvar
  ///   3. `[]` Stake history sysvar that carries stake warmup/cooldown history
  ///   4. [configPubKey] `[]` Address of config account that carries stake config
  ///   5. [authorityPubKey] `[SIGNER]` Stake authority
  ///
  /// The entire balance of the staking account is staked.  DelegateStake
  ///   can be called multiple times, but re-delegation is delayed
  ///   by one epoch
  factory StakeInstruction.delegateStake({
    required String stakePubKey,
    required String votePubKey,
    required String configPubKey,
    required String authorityPubKey,
  }) =>
      StakeInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: stakePubKey, isSigner: false),
          AccountMeta.readonly(pubKey: votePubKey, isSigner: false),
          AccountMeta.readonly(pubKey: Sysvar.clock, isSigner: false),
          AccountMeta.readonly(pubKey: Sysvar.stakeHistory, isSigner: false),
          AccountMeta.readonly(pubKey: configPubKey, isSigner: false),
          AccountMeta.readonly(pubKey: authorityPubKey, isSigner: true),
        ],
        data: StakeProgram.delegateStakeInstructionIndex,
      );

  /// Split [lamports] tokens and stake off a stake account into another stake account.
  ///
  /// # Account references
  ///   0. [sourceStakePubKey] `[WRITE]` Stake account to be split; must be in the Initialized or Stake state
  ///   1. [destinationStakePubKey] `[WRITE]` Uninitialized stake account that will take the split-off amount
  ///   2. [stakeAuthorityPubKey] `[SIGNER]` Stake authority
  factory StakeInstruction.split({
    required String sourceStakePubKey,
    required String destinationStakePubKey,
    required String stakeAuthorityPubKey,
    required int lamports,
  }) =>
      StakeInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: sourceStakePubKey, isSigner: false),
          AccountMeta.writeable(
            pubKey: destinationStakePubKey,
            isSigner: false,
          ),
          AccountMeta.readonly(pubKey: stakeAuthorityPubKey, isSigner: true),
        ],
        data: Buffer.fromConcatenatedByteArrays([
          StakeProgram.splitInstructionIndex,
          Buffer.fromUint64(lamports),
        ]),
      );

  /// Withdraw unstaked [lamports] from the stake account
  ///
  /// # Account references
  ///   0. [stakePubKey] `[WRITE]` Stake account from which to withdraw
  ///   1. [recipientPubKey] `[WRITE]` Recipient account
  ///   2. `[]` Clock sysvar
  ///   3. `[]` Stake history sysvar that carries stake warmup/cooldown history
  ///   4. [authorityPubKey] `[SIGNER]` Withdraw authority
  ///   5. [lockupAuthorityPubKey] Optional: `[SIGNER]` Lockup authority, if before lockup expiration
  ///
  /// The u64 is the portion of the stake account balance to be withdrawn,
  ///    must be `<= StakeAccount.lamports - staked_lamports`.
  factory StakeInstruction.withdraw({
    required String stakePubKey,
    required String recipientPubKey,
    required String authorityPubKey,
    required int lamports,
    String? lockupAuthorityPubKey,
  }) =>
      StakeInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: stakePubKey, isSigner: false),
          AccountMeta.writeable(pubKey: recipientPubKey, isSigner: false),
          AccountMeta.readonly(pubKey: Sysvar.clock, isSigner: false),
          AccountMeta.readonly(pubKey: Sysvar.stakeHistory, isSigner: false),
          AccountMeta.readonly(
            pubKey: authorityPubKey,
            isSigner: true,
          ),
          if (lockupAuthorityPubKey != null)
            AccountMeta.readonly(
              pubKey: lockupAuthorityPubKey,
              isSigner: true,
            )
        ],
        data: Buffer.fromConcatenatedByteArrays([
          StakeProgram.withdrawInstructionIndex,
          Buffer.fromUint64(lamports),
        ]),
      );

  /// Deactivates the stake in the account
  ///
  /// # Account references
  ///   0. [stakePubKey] `[WRITE]` Delegated stake account
  ///   1. `[]` Clock sysvar
  ///   2. [authorityPubKey] `[SIGNER]` Stake authority
  factory StakeInstruction.deactivate({
    required String stakePubKey,
    required String authorityPubKey,
  }) =>
      StakeInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: stakePubKey, isSigner: false),
          AccountMeta.readonly(pubKey: Sysvar.clock, isSigner: false),
          AccountMeta.readonly(pubKey: authorityPubKey, isSigner: true),
        ],
        data: StakeProgram.deactivateInstructionIndex,
      );

  /// Set stake [lockup]
  ///
  /// If a lockup is not active, the withdraw authority may set a new lockup
  /// If a lockup is active, the lockup custodian may update the lockup parameters
  ///
  /// # Account references
  ///   0. [stakePubKey] `[WRITE]` Initialized stake account
  ///   1. [authorityPubKey] `[SIGNER]` Lockup authority or withdraw authority
  factory StakeInstruction.setLockup({
    required String stakePubKey,
    required String authorityPubKey,
    required Lockup lockup,
  }) =>
      StakeInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: stakePubKey, isSigner: false),
          AccountMeta.readonly(pubKey: authorityPubKey, isSigner: true),
        ],
        data: Buffer.fromConcatenatedByteArrays([
          StakeProgram.setLockupInstructionIndex,
          lockup.serialize(),
        ]),
      );

  /// Merge two stake accounts.
  ///
  /// Both accounts must have identical lockup and authority keys. A merge
  /// is possible between two stakes in the following states with no additional
  /// conditions:
  ///
  /// * two deactivated stakes
  /// * an inactive stake into an activating stake during its activation epoch
  ///
  /// For the following cases, the voter pubkey and vote credits observed must match:
  ///
  /// * two activated stakes
  /// * two activating accounts that share an activation epoch, during the activation epoch
  ///
  /// All other combinations of stake states will fail to merge, including all
  /// "transient" states, where a stake is activating or deactivating with a
  /// non-zero effective stake.
  ///
  /// # Account references
  ///   0. [destinationStakePubKey] `[WRITE]` Destination stake account for the merge
  ///   1. [sourceStakePubKey] `[WRITE]` Source stake account for to merge.  This account will be drained
  ///   2. `[]` Clock sysvar
  ///   3. `[]` Stake history sysvar that carries stake warmup/cooldown history
  ///   4. [authorityPubKey] `[SIGNER]` Stake authority
  factory StakeInstruction.merge({
    required String destinationStakePubKey,
    required String sourceStakePubKey,
    required String authorityPubKey,
  }) =>
      StakeInstruction._(
        accounts: [
          AccountMeta.writeable(
            pubKey: destinationStakePubKey,
            isSigner: false,
          ),
          AccountMeta.writeable(pubKey: sourceStakePubKey, isSigner: false),
          AccountMeta.readonly(pubKey: Sysvar.clock, isSigner: false),
          AccountMeta.readonly(pubKey: Sysvar.stakeHistory, isSigner: false),
          AccountMeta.readonly(pubKey: authorityPubKey, isSigner: true),
        ],
        data: StakeProgram.mergeInstructionIndex,
      );

  /// Authorize a key to manage stake or withdrawal with a derived key
  ///
  /// # Account references
  ///   0. `[WRITE]` Stake account to be updated
  ///   1. `[SIGNER]` Base key of stake or withdraw authority
  ///   2. `[]` Clock sysvar
  ///   3. Optional: `[SIGNER]` Lockup authority, if updating StakeAuthorize::Withdrawer before
  ///      lockup expiration
  factory StakeInstruction.authorizeWithSeed({
    required String stakePubKey,
    required String authorityBasePubKey,
    required AuthorizeWithSeedArgs args,
    String? lockupAuthority,
  }) =>
      StakeInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: stakePubKey, isSigner: false),
          AccountMeta.readonly(pubKey: authorityBasePubKey, isSigner: true),
          AccountMeta.readonly(pubKey: Sysvar.clock, isSigner: false),
          if (lockupAuthority != null)
            AccountMeta.readonly(
              pubKey: lockupAuthority,
              isSigner: true,
            ),
        ],
        data: Buffer.fromConcatenatedByteArrays([
          StakeProgram.authorizeWithSeedInstructionIndex,
          args.serialize(),
        ]),
      );

  /// Initialize a stake with authorization information
  ///
  /// This instruction is similar to `Initialize` except that the withdraw authority
  /// must be a signer, and no lockup is applied to the account.
  ///
  /// # Account references
  ///   0. `[WRITE]` Uninitialized stake account
  ///   1. `[]` Rent sysvar
  ///   2. `[]` The stake authority
  ///   3. `[SIGNER]` The withdraw authority
  ///
  factory StakeInstruction.initializeChecked({
    required String stakePubKey,
    required String stakeAuthorityPubKey,
    required String withdrawAuthorityPubKey,
  }) =>
      StakeInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: stakePubKey, isSigner: false),
          AccountMeta.readonly(pubKey: Sysvar.rent, isSigner: false),
          AccountMeta.readonly(pubKey: stakeAuthorityPubKey, isSigner: false),
          AccountMeta.readonly(pubKey: withdrawAuthorityPubKey, isSigner: true),
        ],
        data: StakeProgram.initializeCheckedInstructionIndex,
      );

  /// Authorize a key to manage stake or withdrawal
  ///
  /// This instruction behaves like `Authorize` with the additional requirement that the new
  /// stake or withdraw authority must also be a signer.
  ///
  /// # Account references
  ///   0. `[WRITE]` Stake account to be updated
  ///   1. `[]` Clock sysvar
  ///   2. `[SIGNER]` The stake or withdraw authority
  ///   3. `[SIGNER]` The new stake or withdraw authority
  ///   4. Optional: `[SIGNER]` Lockup authority, if updating StakeAuthorize::Withdrawer before
  ///      lockup expiration
  factory StakeInstruction.authorizeChecked({
    required String stakePubKey,
    required String authorityPubKey,
    required StakeAuthorize stakeAuthorize,
    String? lockupAuthorityPubKey,
  }) =>
      StakeInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: stakePubKey, isSigner: false),
          AccountMeta.readonly(pubKey: Sysvar.clock, isSigner: false),
          AccountMeta.readonly(pubKey: authorityPubKey, isSigner: true),
          AccountMeta.readonly(pubKey: stakeAuthorize.pubKey, isSigner: true),
          if (lockupAuthorityPubKey != null)
            AccountMeta.readonly(
              pubKey: lockupAuthorityPubKey,
              isSigner: true,
            ),
        ],
        data: Buffer.fromConcatenatedByteArrays([
          StakeProgram.authorizeCheckedInstructionIndex,
          stakeAuthorize.serialize(),
        ]),
      );

  /// Authorize a key to manage stake or withdrawal with a derived key
  ///
  /// This instruction behaves like `AuthorizeWithSeed` with the additional requirement that
  /// the new stake or withdraw authority must also be a signer.
  ///
  /// # Account references
  ///   0. `[WRITE]` Stake account to be updated
  ///   1. `[SIGNER]` Base key of stake or withdraw authority
  ///   2. `[]` Clock sysvar
  ///   3. `[SIGNER]` The new stake or withdraw authority
  ///   4. Optional: `[SIGNER]` Lockup authority, if updating StakeAuthorize::Withdrawer before
  ///      lockup expiration
  factory StakeInstruction.authorizeCheckedWithSeed({
    required String stakePubKey,
    required String base,
    required String authorityPubKey,
    required AuthorizeWithSeedArgs authorizeWithSeedArgs,
    String? lockupAuthorityPubKey,
  }) =>
      StakeInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: stakePubKey, isSigner: false),
          AccountMeta.readonly(pubKey: base, isSigner: true),
          AccountMeta.readonly(pubKey: Sysvar.clock, isSigner: false),
          AccountMeta.readonly(
            pubKey: authorizeWithSeedArgs.stakeAuthorize.pubKey,
            isSigner: true,
          ),
          if (lockupAuthorityPubKey != null)
            AccountMeta.readonly(
              pubKey: lockupAuthorityPubKey,
              isSigner: true,
            ),
        ],
        data: Buffer.fromConcatenatedByteArrays([
          StakeProgram.authorizeCheckedInstructionIndex,
          authorizeWithSeedArgs.serialize(),
        ]),
      );

  /// Set stake lockup
  ///
  /// This instruction behaves like `SetLockup` with the additional requirement that
  /// the new lockup authority also be a signer.
  ///
  /// If a lockup is not active, the withdraw authority may set a new lockup
  /// If a lockup is active, the lockup custodian may update the lockup parameters
  ///
  /// # Account references
  ///   0. `[WRITE]` Initialized stake account
  ///   1. `[SIGNER]` Lockup authority or withdraw authority
  ///   2. Optional: `[SIGNER]` New lockup authority
  factory StakeInstruction.setLockupChecked({
    required String stakePubKey,
    required String authorityPubKey,
    required LockupCheckedArgs lockupCheckedArgs,
  }) =>
      StakeInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: stakePubKey, isSigner: false),
          AccountMeta.writeable(pubKey: authorityPubKey, isSigner: true),
        ],
        data: Buffer.fromConcatenatedByteArrays([
          StakeProgram.setLockupInstructionIndex,
          lockupCheckedArgs.serialize(),
        ]),
      );
}

class LockupCheckedArgs {
  const LockupCheckedArgs({
    required this.unixTimestamp,
    required this.epoch,
  });

  ByteArray serialize() => Buffer.fromConcatenatedByteArrays([
        Buffer.fromInt64(this.unixTimestamp),
        Buffer.fromUint64(this.epoch),
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

  ByteArray serialize() => Buffer.fromConcatenatedByteArrays([
        stakeAuthorize.serialize(),
        Buffer.fromString(authoritySeed),
        Buffer.fromBase58(authorityOwnerPubKey),
      ]);

  final StakeAuthorize stakeAuthorize;
  final String authoritySeed;
  final String authorityOwnerPubKey;
}
