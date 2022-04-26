import 'package:solana/src/crypto/ed25519_hd_public_key.dart';

export 'exceptions.dart';
export 'instruction.dart';
export 'mint.dart';
export 'solana_client_ext.dart';

/// Construct token programs conveniently
abstract class TokenProgram {
  static const programId = 'TokenkegQfeZyiNwAJbNbGKPFXCWuBvf9Ss623VQ5DA';

  static final Ed25519HDPublicKey id = Ed25519HDPublicKey.fromBase58(programId);

  // Instruction indexes
  static const initializeMintInstructionIndex = [0];
  static const initializeAccountInstructionIndex = [1];
  static const initializeMultisigInstructionIndex = [2];
  static const transferInstructionIndex = [3];
  static const approveInstructionIndex = [4];
  static const revokeInstructionIndex = [5];
  static const setAuthorityInstructionIndex = [6];
  static const mintToInstructionIndex = [7];
  static const burnInstructionIndex = [8];
  static const closeAccountInstructionIndex = [9];
  static const freezeAccountInstructionIndex = [10];
  static const thawAccountInstructionIndex = [11];
  static const transferCheckedInstructionIndex = [12];
  static const approveCheckedInstructionIndex = [13];
  static const mintToCheckedInstructionIndex = [14];
  static const burnCheckedInstructionIndex = [15];
  static const initializeAccount2InstructionIndex = [16];
  static const syncNativeInstructionIndex = [17];
  static const initializeAccount3InstructionIndex = [18];
  static const initializeMultisig2InstructionIndex = [19];
  static const initializeMint2InstructionIndex = [20];

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
