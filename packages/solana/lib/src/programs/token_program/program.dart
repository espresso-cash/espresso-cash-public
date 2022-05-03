import 'package:solana/src/crypto/ed25519_hd_public_key.dart';
import 'package:solana/src/encoder/byte_array.dart';

export 'exceptions.dart';
export 'instruction.dart';
export 'mint.dart';
export 'solana_client_ext.dart';

/// Construct token programs conveniently
abstract class TokenProgram {
  static const programId = 'TokenkegQfeZyiNwAJbNbGKPFXCWuBvf9Ss623VQ5DA';

  static final Ed25519HDPublicKey id = Ed25519HDPublicKey.fromBase58(programId);

  // Instruction indexes
  static final initializeMintInstructionIndex = ByteArray([0]);
  static final initializeAccountInstructionIndex = ByteArray([1]);
  static final initializeMultisigInstructionIndex = ByteArray([2]);
  static final transferInstructionIndex = ByteArray([3]);
  static final approveInstructionIndex = ByteArray([4]);
  static final revokeInstructionIndex = ByteArray([5]);
  static final setAuthorityInstructionIndex = ByteArray([6]);
  static final mintToInstructionIndex = ByteArray([7]);
  static final burnInstructionIndex = ByteArray([8]);
  static final closeAccountInstructionIndex = ByteArray([9]);
  static final freezeAccountInstructionIndex = ByteArray([10]);
  static final thawAccountInstructionIndex = ByteArray([11]);
  static final transferCheckedInstructionIndex = ByteArray([12]);
  static final approveCheckedInstructionIndex = ByteArray([13]);
  static final mintToCheckedInstructionIndex = ByteArray([14]);
  static final burnCheckedInstructionIndex = ByteArray([15]);
  static final initializeAccount2InstructionIndex = ByteArray([16]);
  static final syncNativeInstructionIndex = ByteArray([17]);
  static final initializeAccount3InstructionIndex = ByteArray([18]);
  static final initializeMultisig2InstructionIndex = ByteArray([19]);
  static final initializeMint2InstructionIndex = ByteArray([20]);

  // This is computed by adding the bytes in the following
  // structure
  //
  // mintAuthorityOption:   int32 ( 4 bytes)
  // mintAuthority:        PubKey (32 bytes)
  // supply:                int64 ( 8 bytes)
  // decimals:               byte ( 1 bytes)
  // isInitialized:          byte ( 1 bytes)
  // freezeAuthorityOption: int32 ( 4 bytes)
  // freezeAuthority:      PubKey (32 bytes)
  static const neededMintAccountSpace = 82;

  // This is computed by adding the bytes in the following
  // structure
  //
  // mint:                 PubKey (32 bytes)
  // owner:                PubKey (32 bytes)
  // amount:               uint64 ( 8 bytes)
  // delegateOption:       uint32 ( 4 bytes)
  // delegate:             PubKey (32 bytes)
  // state:                byte   ( 1 bytes)
  // isNativeOption:       uint32 ( 4 bytes)
  // isNative:             uint64 ( 8 bytes)
  // delegatedAmount:      uint64 ( 8 bytes)
  // closeAuthorityOption: uint32 ( 4 bytes)
  // closeAuthority:       PubKey (32 bytes)
  static const neededAccountSpace = 165;
}
