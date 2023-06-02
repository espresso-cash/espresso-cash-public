import 'package:solana/src/crypto/ed25519_hd_public_key.dart';
import 'package:solana/src/encoder/byte_array.dart';

export 'instruction.dart';
export 'state.dart';

abstract class StakeProgram {
  static const programId = 'Stake11111111111111111111111111111111111111';

  static final Ed25519HDPublicKey id = Ed25519HDPublicKey.fromBase58(programId);

  static final initializeInstructionIndex = ByteArray(const [0, 0, 0, 0]);
  static final authorizeInstructionIndex = ByteArray(const [1, 0, 0, 0]);
  static final delegateStakeInstructionIndex = ByteArray(const [2, 0, 0, 0]);
  static final splitInstructionIndex = ByteArray(const [3, 0, 0, 0]);
  static final withdrawInstructionIndex = ByteArray(const [4, 0, 0, 0]);
  static final deactivateInstructionIndex = ByteArray(const [5, 0, 0, 0]);
  static final setLockupInstructionIndex = ByteArray(const [6, 0, 0, 0]);
  static final mergeInstructionIndex = ByteArray(const [7, 0, 0, 0]);
  static final authorizeWithSeedInstructionIndex =
      ByteArray(const [8, 0, 0, 0]);
  static final initializeCheckedInstructionIndex =
      ByteArray(const [9, 0, 0, 0]);
  static final authorizeCheckedInstructionIndex =
      ByteArray(const [10, 0, 0, 0]);
  static final authorizeCheckedWithSeedInstructionIndex =
      ByteArray(const [11, 0, 0, 0]);
  static final setLockupCheckedIndex = ByteArray(const [12, 0, 0, 0]);

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
