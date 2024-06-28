import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

//TODO: token2022 should also have index from TokenProgram
abstract class Token2022Program {
  static const programId = 'TokenzQdBNbLqP5VEhdkAS6EPFLC1PHnBqCXEpPxuEb';

  static final Ed25519HDPublicKey id = Ed25519HDPublicKey.fromBase58(programId);

  static final initializeMintCloseAuthorityInstructionIndex =
      ByteArray(const [25]);
  static final reallocateInstructionIndex = ByteArray(const [29]);
  static final createNativeMintInstructionIndex = ByteArray(const [31]);
  static final initializeNonTransferableMintInstructionIndex =
      ByteArray(const [32]);
  static final initializePermanentDelegateInstructionIndex =
      ByteArray(const [35]);
}
