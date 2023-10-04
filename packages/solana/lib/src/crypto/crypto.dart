import 'package:cryptography/cryptography.dart';
import 'package:solana/solana.dart';

export 'ed25519_hd_keypair.dart';
export 'ed25519_hd_keypair_data.dart';
export 'ed25519_hd_public_key.dart';
export 'signature.dart';

Future<bool> verifySignature({
  required List<int> message,
  required List<int> signature,
  required Ed25519HDPublicKey publicKey,
}) {
  final alg = Ed25519();

  return alg.verify(
    message,
    signature: Signature(
      signature,
      publicKey: SimplePublicKey(publicKey.bytes, type: KeyPairType.ed25519),
    ),
  );
}
