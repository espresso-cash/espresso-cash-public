import 'package:cryptography/cryptography.dart';
import 'package:ed25519_hd_key/ed25519_hd_key.dart';

class HDKeyPair implements SimpleKeyPair {
  HDKeyPair._({
    required KeyData private,
    required List<int> publicKey,
  })  : _private = private,
        _publicKey = publicKey;

  static Future<KeyPair> fromSeed(List<int> seed, String hdPath) async {
    final KeyData private = await ED25519_HD_KEY.derivePath(hdPath, seed);
    final List<int> publicKey = await ED25519_HD_KEY.getPublicKey(
      private.key,
      false,
    );
    return HDKeyPair._(private: private, publicKey: publicKey);
  }

  final KeyData _private;
  final List<int> _publicKey;

  @override
  Future<SimpleKeyPairData> extract() async => SimpleKeyPairData(
        _private.key,
        publicKey: await extractPublicKey(),
        type: KeyPairType.ed25519,
      );

  @override
  Future<SimplePublicKey> extractPublicKey() => Future<SimplePublicKey>.value(
        SimplePublicKey(_publicKey, type: KeyPairType.ed25519),
      );

  @override
  Future<List<int>> extractPrivateKeyBytes() =>
      Future<List<int>>.value(_private.key);
}
