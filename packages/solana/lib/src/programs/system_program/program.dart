import 'package:solana/src/crypto/ed25519_hd_public_key.dart';
import 'package:solana/src/encoder/byte_array.dart';

export 'instruction.dart';
export 'solana_client_ext.dart';

abstract class SystemProgram {
  static const programId = '11111111111111111111111111111111';

  static final Ed25519HDPublicKey id = Ed25519HDPublicKey.fromBase58(programId);

  static final createAccountInstructionIndex = ByteArray([0, 0, 0, 0]);
  static final assignInstructionIndex = ByteArray([1, 0, 0, 0]);
  static final transferInstructionIndex = ByteArray([2, 0, 0, 0]);
  static final createAccountWithSeedInstructionIndex = ByteArray([3, 0, 0, 0]);
  static final advanceNonceAccountInstructionIndex = ByteArray([4, 0, 0, 0]);
  static final withdrawNonceAccountInstructionIndex = ByteArray([5, 0, 0, 0]);
  static final initializeNonceAccountInstructionIndex = ByteArray([6, 0, 0, 0]);
  static final authorizeNonceAccountInstructionIndex = ByteArray([7, 0, 0, 0]);
  static final allocateInstructionIndex = ByteArray([8, 0, 0, 0]);
  static final allocateWithSeedInstructionIndex = ByteArray([9, 0, 0, 0]);
  static final assignWithSeedInstructionIndex = ByteArray([10, 0, 0, 0]);
  static final transferWithSeedInstructionIndex = ByteArray([11, 0, 0, 0]);

  // Note: in the rust sdk this is computed dynamically.
  //
  // Currently the object has 3 fields
  //
  // - Authority (PubKey) 32 bytes
  // - Blockhash (32 + 8) bytes
  // - FeeCalculator (lamportsPerSol int64) (8 bytes)
  static const nonceAccountSize = 80;
}
