import 'package:solana/src/crypto/ed25519_hd_public_key.dart';

export 'instruction.dart';
export 'state.dart';

abstract class StakeProgram {
  static const programId = 'Stake11111111111111111111111111111111111111';

  static final Ed25519HDPublicKey id = Ed25519HDPublicKey.fromBase58(programId);

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
