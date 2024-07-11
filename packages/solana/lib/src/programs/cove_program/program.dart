import 'package:solana/src/crypto/ed25519_hd_public_key.dart';

export 'instruction.dart';

abstract class CoveProgram {
  static const programId = '2zG2G696WnzNVPzP7MCPgQ5fJZnhYDsR71UUHCB4fdfW';

  static final Ed25519HDPublicKey id = Ed25519HDPublicKey.fromBase58(programId);
}
