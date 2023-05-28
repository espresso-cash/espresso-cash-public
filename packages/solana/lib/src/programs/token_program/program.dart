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
  static final initializeMintInstructionIndex = ByteArray(const [0]);
  static final initializeAccountInstructionIndex = ByteArray(const [1]);
  static final initializeMultisigInstructionIndex = ByteArray(const [2]);
  static final transferInstructionIndex = ByteArray(const [3]);
  static final approveInstructionIndex = ByteArray(const [4]);
  static final revokeInstructionIndex = ByteArray(const [5]);
  static final setAuthorityInstructionIndex = ByteArray(const [6]);
  static final mintToInstructionIndex = ByteArray(const [7]);
  static final burnInstructionIndex = ByteArray(const [8]);
  static final closeAccountInstructionIndex = ByteArray(const [9]);
  static final freezeAccountInstructionIndex = ByteArray(const [10]);
  static final thawAccountInstructionIndex = ByteArray(const [11]);
  static final transferCheckedInstructionIndex = ByteArray(const [12]);
  static final approveCheckedInstructionIndex = ByteArray(const [13]);
  static final mintToCheckedInstructionIndex = ByteArray(const [14]);
  static final burnCheckedInstructionIndex = ByteArray(const [15]);
  static final initializeAccount2InstructionIndex = ByteArray(const [16]);
  static final syncNativeInstructionIndex = ByteArray(const [17]);
  static final initializeAccount3InstructionIndex = ByteArray(const [18]);
  static final initializeMultisig2InstructionIndex = ByteArray(const [19]);
  static final initializeMint2InstructionIndex = ByteArray(const [20]);

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
