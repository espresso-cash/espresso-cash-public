import 'package:solana/src/crypto/ed25519_hd_public_key.dart';

export 'instruction.dart';
export 'solana_client_ext.dart';

abstract class SystemProgram {
  static const programId = '11111111111111111111111111111111';

  static final Ed25519HDPublicKey id = Ed25519HDPublicKey.fromBase58(programId);

  static const createAccountInstructionIndex = [0, 0, 0, 0];
  static const assignInstructionIndex = [1, 0, 0, 0];
  static const transferInstructionIndex = [2, 0, 0, 0];
  static const createAccountWithSeedInstructionIndex = [3, 0, 0, 0];
  static const advanceNonceAccountInstructionIndex = [4, 0, 0, 0];
  static const withdrawNonceAccountInstructionIndex = [5, 0, 0, 0];
  static const initializeNonceAccountInstructionIndex = [6, 0, 0, 0];
  static const authorizeNonceAccountInstructionIndex = [7, 0, 0, 0];
  static const allocateInstructionIndex = [8, 0, 0, 0];
  static const allocateWithSeedInstructionIndex = [9, 0, 0, 0];
  static const assignWithSeedInstructionIndex = [10, 0, 0, 0];
  static const transferWithSeedInstructionIndex = [11, 0, 0, 0];

  // Note: in the rust sdk this is computed dynamically.
  //
  // Currently the object has 3 fields
  //
  // - Authority (PubKey) 32 bytes
  // - Blockhash (32 + 8) bytes
  // - FeeCalculator (lamportsPerSol int64) (8 bytes)
  static const nonceAccountSize = 80;
}
