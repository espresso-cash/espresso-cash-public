import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

//TODO: token2022 should also have index from TokenProgram
abstract class Token2022Program {
  static const programId = 'TokenzQdBNbLqP5VEhdkAS6EPFLC1PHnBqCXEpPxuEb';

  static final Ed25519HDPublicKey id = Ed25519HDPublicKey.fromBase58(programId);

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
