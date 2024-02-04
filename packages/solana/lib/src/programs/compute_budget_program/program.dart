import 'package:solana/encoder.dart';
import 'package:solana/src/crypto/ed25519_hd_public_key.dart';

export 'instruction.dart';

abstract class ComputeBudgetProgram {
  static const programId = 'ComputeBudget111111111111111111111111111111';

  static final Ed25519HDPublicKey id = Ed25519HDPublicKey.fromBase58(programId);

  static final requestUnitsDeprecatedIndex = ByteArray(const [0]);
  static final requestHeapFrameIndex = ByteArray(const [1]);
  static final setComputeUnitLimitIndex = ByteArray(const [2]);
  static final setComputeUnitPriceIndex = ByteArray(const [3]);
  static final setLoadedAccountsDataSizeLimitIndex = ByteArray(const [4]);
}
