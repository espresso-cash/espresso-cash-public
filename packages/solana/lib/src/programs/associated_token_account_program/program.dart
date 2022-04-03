import 'package:solana/src/crypto/ed25519_hd_public_key.dart';

export 'instruction.dart';
export 'solana_client_ext.dart';

abstract class AssociatedTokenAccountProgram {
  static const programId = 'ATokenGPvbdGVxr1b2hvZbsiqW5xWH25efTNsLJA8knL';

  static final Ed25519HDPublicKey id = Ed25519HDPublicKey.fromBase58(programId);
}
