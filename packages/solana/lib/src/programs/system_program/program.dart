import 'package:solana/src/crypto/ed25519_hd_public_key.dart';
import 'package:solana/src/encoder/byte_array.dart';

export 'instruction.dart';
export 'solana_client_ext.dart';

abstract class SystemProgram {
  static const programId = '11111111111111111111111111111111';

  static final Ed25519HDPublicKey id = Ed25519HDPublicKey.fromBase58(programId);

  static final createAccountInstructionIndex = ByteArray(const [0, 0, 0, 0]);
  static final assignInstructionIndex = ByteArray(const [1, 0, 0, 0]);
  static final transferInstructionIndex = ByteArray(const [2, 0, 0, 0]);
  static final createAccountWithSeedInstructionIndex =
      ByteArray(const [3, 0, 0, 0]);
  static final advanceNonceAccountInstructionIndex =
      ByteArray(const [4, 0, 0, 0]);
  static final withdrawNonceAccountInstructionIndex =
      ByteArray(const [5, 0, 0, 0]);
  static final initializeNonceAccountInstructionIndex =
      ByteArray(const [6, 0, 0, 0]);
  static final authorizeNonceAccountInstructionIndex =
      ByteArray(const [7, 0, 0, 0]);
  static final allocateInstructionIndex = ByteArray(const [8, 0, 0, 0]);
  static final allocateWithSeedInstructionIndex = ByteArray(const [9, 0, 0, 0]);
  static final assignWithSeedInstructionIndex = ByteArray(const [10, 0, 0, 0]);
  static final transferWithSeedInstructionIndex =
      ByteArray(const [11, 0, 0, 0]);

  // Note: in the rust sdk this is computed dynamically.
  //
  // Currently the object has 3 fields
  //
  // - Authority (PubKey) 32 bytes
  // - Blockhash (32 + 8) bytes
  // - FeeCalculator (lamportsPerSol int64) (8 bytes)
  static const nonceAccountSize = 80;
}
