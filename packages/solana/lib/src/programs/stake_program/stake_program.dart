import 'package:solana/src/crypto/ed25519_hd_keypair.dart';
import 'package:solana/src/encoder/instruction.dart';
import 'package:solana/src/encoder/message.dart';
import 'package:solana/src/programs/stake_program/stake_instruction.dart';
import 'package:solana/src/programs/stake_program/state.dart';
import 'package:solana/src/programs/system_program/system_instruction.dart';
import 'package:solana/src/programs/system_program/system_program.dart';
import 'package:solana/src/rpc/dto/account_data/stake_program/authorized.dart';
import 'package:solana/src/rpc/dto/account_data/stake_program/lockup.dart';

class StakeProgram extends Message {
  StakeProgram._({
    required List<Instruction> instructions,
  }) : super(instructions: instructions);

  factory StakeProgram.createAccount({
    required Ed25519HDPublicKey fromPubKey,
    required Ed25519HDPublicKey stakePubKey,
    required Authorized authorized,
    required int lamports,
    Lockup lockup = const Lockup.none(),
  }) =>
      StakeProgram._(instructions: [
        SystemInstruction.createAccount(
          pubKey: stakePubKey,
          fromPubKey: fromPubKey,
          lamports: lamports,
          space: StakeProgram.neededAccountSpace,
          owner: Ed25519HDPublicKey.fromBase58(StakeProgram.programId),
        ),
        StakeInstruction.initialize(
          stakePubKey: stakePubKey,
          authorized: authorized,
          lockup: lockup,
        ),
      ]);

  factory StakeProgram.createAccountWithSeed({
    required Ed25519HDPublicKey fromPubKey,
    required Ed25519HDPublicKey stakePubKey,
    required Authorized authorized,
    required Ed25519HDPublicKey base,
    required String seed,
    required int lamports,
    Lockup lockup = const Lockup.none(),
  }) =>
      StakeProgram._(instructions: [
        SystemInstruction.createAccountWithSeed(
          fromPubKey: fromPubKey,
          pubKey: stakePubKey,
          lamports: lamports,
          space: StakeProgram.neededAccountSpace,
          owner: Ed25519HDPublicKey.fromBase58(StakeProgram.programId),
          seed: seed,
          base: base,
        ),
        StakeInstruction.initialize(
          stakePubKey: stakePubKey,
          authorized: authorized,
          lockup: lockup,
        ),
      ]);

  factory StakeProgram.authorize({
    required Ed25519HDPublicKey stakePubKey,
    required Ed25519HDPublicKey authorityPubKey,
    required StakeAuthorize stakeAuthorize,
    Ed25519HDPublicKey? lockupAuthorityPubKey,
  }) =>
      StakeProgram._(
        instructions: [
          StakeInstruction.authorize(
            stakePubKey: stakePubKey,
            authorityPubKey: authorityPubKey,
            stakeAuthorize: stakeAuthorize,
            lockupAuthorityPubKey: lockupAuthorityPubKey,
          ),
        ],
      );

  factory StakeProgram.delegateStake({
    required Ed25519HDPublicKey stakePubKey,
    required Ed25519HDPublicKey votePubKey,
    required Ed25519HDPublicKey configPubKey,
    required Ed25519HDPublicKey authorityPubKey,
  }) =>
      StakeProgram._(
        instructions: [
          StakeInstruction.delegateStake(
            stakePubKey: stakePubKey,
            votePubKey: votePubKey,
            configPubKey: configPubKey,
            authorityPubKey: authorityPubKey,
          )
        ],
      );

  factory StakeProgram.split({
    required Ed25519HDPublicKey sourceStakePubKey,
    required Ed25519HDPublicKey destinationStakePubKey,
    required Ed25519HDPublicKey stakeAuthorityPubKey,
    required int lamports,
  }) =>
      StakeProgram._(
        instructions: [
          StakeInstruction.split(
            sourceStakePubKey: sourceStakePubKey,
            destinationStakePubKey: destinationStakePubKey,
            stakeAuthorityPubKey: stakeAuthorityPubKey,
            lamports: lamports,
          )
        ],
      );

  factory StakeProgram.withdraw({
    required Ed25519HDPublicKey stakePubKey,
    required Ed25519HDPublicKey recipientPubKey,
    required Ed25519HDPublicKey authorityPubKey,
    required int lamports,
    Ed25519HDPublicKey? lockupAuthorityPubKey,
  }) =>
      StakeProgram._(instructions: [
        StakeInstruction.withdraw(
          stakePubKey: stakePubKey,
          recipientPubKey: recipientPubKey,
          authorityPubKey: authorityPubKey,
          lamports: lamports,
          lockupAuthorityPubKey: lockupAuthorityPubKey,
        )
      ]);

  factory StakeProgram.deactivate({
    required Ed25519HDPublicKey stakePubKey,
    required Ed25519HDPublicKey authorityPubKey,
  }) =>
      StakeProgram._(
        instructions: [
          StakeInstruction.deactivate(
            stakePubKey: stakePubKey,
            authorityPubKey: authorityPubKey,
          )
        ],
      );

  factory StakeProgram.setLockup({
    required Ed25519HDPublicKey stakePubKey,
    required Ed25519HDPublicKey authorityPubKey,
    required Lockup lockup,
  }) =>
      StakeProgram._(
        instructions: [
          StakeInstruction.setLockup(
            stakePubKey: stakePubKey,
            authorityPubKey: authorityPubKey,
            lockup: lockup,
          )
        ],
      );

  factory StakeProgram.merge({
    required Ed25519HDPublicKey destinationStakePubKey,
    required Ed25519HDPublicKey sourceStakePubKey,
    required Ed25519HDPublicKey authorityPubKey,
  }) =>
      StakeProgram._(instructions: [
        StakeInstruction.merge(
          destinationStakePubKey: destinationStakePubKey,
          sourceStakePubKey: sourceStakePubKey,
          authorityPubKey: authorityPubKey,
        )
      ]);

  factory StakeProgram.authorizeWithSeed({
    required Ed25519HDPublicKey stakePubKey,
    required Ed25519HDPublicKey authorityBasePubKey,
    required AuthorizeWithSeedArgs authorizeWithSeedArgs,
    Ed25519HDPublicKey? lockupAuthority,
  }) =>
      StakeProgram._(
        instructions: [
          StakeInstruction.authorizeWithSeed(
            stakePubKey: stakePubKey,
            authorityBasePubKey: authorityBasePubKey,
            args: authorizeWithSeedArgs,
            lockupAuthority: lockupAuthority,
          )
        ],
      );

  factory StakeProgram.authorizeChecked({
    required Ed25519HDPublicKey stakePubKey,
    required Ed25519HDPublicKey authorityPubKey,
    required StakeAuthorize stakeAuthorize,
    Ed25519HDPublicKey? lockupAuthorityPubKey,
  }) =>
      StakeProgram._(
        instructions: [
          StakeInstruction.authorizeChecked(
            stakePubKey: stakePubKey,
            authorityPubKey: authorityPubKey,
            stakeAuthorize: stakeAuthorize,
            lockupAuthorityPubKey: lockupAuthorityPubKey,
          )
        ],
      );

  factory StakeProgram.authorizeCheckedWithSeed({
    required Ed25519HDPublicKey stakePubKey,
    required Ed25519HDPublicKey base,
    required Ed25519HDPublicKey authorityPubKey,
    required AuthorizeWithSeedArgs authorizeWithSeedArgs,
    Ed25519HDPublicKey? lockupAuthorityPubKey,
  }) =>
      StakeProgram._(
        instructions: [
          StakeInstruction.authorizeCheckedWithSeed(
            stakePubKey: stakePubKey,
            base: base,
            authorityPubKey: authorityPubKey,
            authorizeWithSeedArgs: authorizeWithSeedArgs,
            lockupAuthorityPubKey: lockupAuthorityPubKey,
          )
        ],
      );

  factory StakeProgram.setLockupChecked({
    required Ed25519HDPublicKey stakePubKey,
    required Ed25519HDPublicKey authorityPubKey,
    required LockupCheckedArgs lockupCheckedArgs,
  }) =>
      StakeProgram._(
        instructions: [
          StakeInstruction.setLockupChecked(
            stakePubKey: stakePubKey,
            authorityPubKey: authorityPubKey,
            lockupCheckedArgs: lockupCheckedArgs,
          )
        ],
      );

  static const programId = 'Stake11111111111111111111111111111111111111';

  static const initializeInstructionIndex = [0, 0, 0, 0];
  static const authorizeInstructionIndex = [1, 0, 0, 0];
  static const delegateStakeInstructionIndex = [2, 0, 0, 0];
  static const splitInstructionIndex = [3, 0, 0, 0];
  static const withdrawInstructionIndex = [4, 0, 0, 0];
  static const deactivateInstructionIndex = [5, 0, 0, 0];
  static const setLockupInstructionIndex = [6, 0, 0, 0];
  static const mergeInstructionIndex = [7, 0, 0, 0];
  static const authorizeWithSeedInstructionIndex = [8, 0, 0, 0];
  static const initializeCheckedInstructionIndex = [9, 0, 0, 0];
  static const authorizeCheckedInstructionIndex = [10, 0, 0, 0];
  static const authorizeCheckedWithSeedInstructionIndex = [11, 0, 0, 0];
  static const setLockupCheckedIndex = [12, 0, 0, 0];

  // This is the maximum size that a stake account can use (192 bytes)
  // Meta                                (120 bytes)
  //   rent_exempt_reserve uint64        (  8 bytes)
  //   authorized          Authorized    ( 64 bytes)
  //     staker     PubKey (32 bytes)
  //     withdrawer PubKey (32 bytes)
  //   lockup              Lockup        ( 48 bytes)
  //     unix_timestamp UnixTimestamp ( 8 bytes)
  //     epoch          Epoch         ( 8 bytes)
  //     custodian      PubKey        (32 bytes)
  // Stake                               ( 72 bytes)
  //   credits_observed uint64     (8 bytes)
  //   delegation       Delegation (64 bytes)
  //     voter_pubkey         PubKey  (32 bytes)
  //     stake                uint64  ( 8 bytes)
  //     activation_epoch     Epoch   ( 8 bytes)
  //     deactivation_epoch   Epoch   ( 8 bytes)
  //     warmup_cooldown_rate float64 ( 8 bytes)
  static const neededAccountSpace = 200;
}
