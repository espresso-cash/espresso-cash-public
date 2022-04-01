import 'package:solana/src/crypto/ed25519_hd_public_key.dart';

export 'package:solana/src/programs/memo_program/memo_instruction.dart';

/// The memo program from the SPL.
abstract class MemoProgram {
  static const programId = 'MemoSq4gqABAXKb96qnH8TysNcWxMyWCqXgDLGmfcHr';

  static final Ed25519HDPublicKey id = Ed25519HDPublicKey.fromBase58(programId);
}
