import 'package:cryptography/cryptography.dart';
import 'package:ed25519_hd_key/ed25519_hd_key.dart';

class HDKeyPair implements SimpleKeyPair {
  HDKeyPair._({
    required KeyData privateKey,
    required List<int> publicKey,
  })  : _privateKey = privateKey,
        _publicKey = publicKey;

  static Future<KeyPair> fromSeedWithHdPath({
    required List<int> seed,
    required String hdPath,
  }) async {
    final KeyData privateKey = await ED25519_HD_KEY.derivePath(hdPath, seed);
    return HDKeyPair._(
      privateKey: privateKey,
      publicKey: await ED25519_HD_KEY.getPublicKey(privateKey.key, false),
    );
  }

  final KeyData _privateKey;
  final List<int> _publicKey;

  @override
  Future<SimpleKeyPairData> extract() async => SimpleKeyPairData(
        _privateKey.key,
        publicKey: await extractPublicKey(),
        type: KeyPairType.ed25519,
      );

  @override
  Future<SimplePublicKey> extractPublicKey() => Future<SimplePublicKey>.value(
        SimplePublicKey(_publicKey, type: KeyPairType.ed25519),
      );

  @override
  Future<List<int>> extractPrivateKeyBytes() =>
      Future<List<int>>.value(_privateKey.key);
}
