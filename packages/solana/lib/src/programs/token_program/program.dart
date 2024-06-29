import 'package:solana/src/crypto/ed25519_hd_public_key.dart';
import 'package:solana/src/encoder/byte_array.dart';

export 'exceptions.dart';
export 'extension_type.dart';
export 'instruction.dart';
export 'mint.dart';
export 'solana_client_ext.dart';
export 'token_program_type.dart';

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
  static final getAccountDataSizeInstructionIndex = ByteArray(const [21]);
  static final initializeImmutableOwnerInstructionIndex = ByteArray(const [22]);
  static final amountToUiAmountInstructionIndex = ByteArray(const [23]);
  static final uiAmountToAmountInstructionIndex = ByteArray(const [24]);

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

abstract class Token2022Program {
  static const programId = 'TokenzQdBNbLqP5VEhdkAS6EPFLC1PHnBqCXEpPxuEb';

  static final Ed25519HDPublicKey id = Ed25519HDPublicKey.fromBase58(programId);

  // Token 2022 Instruction indexes
  static final initializeMintCloseAuthorityInstructionIndex =
      ByteArray(const [25]);
  static final transferFeeExtensionInstructionIndex = ByteArray(const [26]);
  static final confidentialTransferExtensionInstructionIndex =
      ByteArray(const [27]);
  static final defaultAccountStateExtensionInstructionIndex =
      ByteArray(const [28]);
  static final reallocateInstructionIndex = ByteArray(const [29]);
  static final memoTransferExtensionInstructionIndex = ByteArray(const [30]);
  static final createNativeMintInstructionIndex = ByteArray(const [31]);
  static final initializeNonTransferableMintInstructionIndex =
      ByteArray(const [32]);
  static final interestBearingMintExtensionInstructionIndex =
      ByteArray(const [33]);
  static final cpiGuardExtensionInstructionIndex = ByteArray(const [34]);
  static final initializePermanentDelegateInstructionIndex =
      ByteArray(const [35]);
  static final transferHookExtensionInstructionIndex = ByteArray(const [36]);
  static final confidentialTransferFeeExtensionInstructionIndex =
      ByteArray(const [37]);
  static final withdrawExcessLamportsInstructionIndex = ByteArray(const [38]);
  static final metadataPointerExtensionInstructionIndex = ByteArray(const [39]);
  static final groupPointerExtensionInstructionIndex = ByteArray(const [40]);
  static final groupMemberPointerExtensionInstructionIndex =
      ByteArray(const [41]);
}

final nativeMint2022 = Ed25519HDPublicKey.fromBase58(
  '9pan9bMn5HatX4EJdBwg9VgCa7Uz5HL8N1m5D3NdXejP',
);
