import 'dart:async';
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import 'package:solana/src/crypto/ed25519_hd_public_key.dart';

class Ed25519HDKeyPairData implements KeyPairData {
  Ed25519HDKeyPairData(
    List<int> bytes, {
    required this.publicKey,
  }) : _bytes = SensitiveBytes(bytes);

  final SensitiveBytes _bytes;

  @override
  final Ed25519HDPublicKey publicKey;

  List<int> get bytes {
    if (hasBeenDestroyed) throw _destroyedError();

    return Uint8List.fromList(_bytes);
  }

  @override
  // ignore: use_to_and_as_if_applicable, overridden method
  Future<Ed25519HDKeyPairData> extract() async {
    if (hasBeenDestroyed) throw _destroyedError();

    return this;
  }

  @override
  Future<Ed25519HDPublicKey> extractPublicKey() async => publicKey;

  @override
  KeyPairType<KeyPairData, PublicKey> get type => KeyPairType.ed25519;

  @override
  Ed25519HDKeyPairData copy() {
    if (hasBeenDestroyed) throw _destroyedError();

    return Ed25519HDKeyPairData(bytes, publicKey: publicKey);
  }

  @override
  void destroy() => _bytes.destroy();

  @override
  bool get hasBeenDestroyed => _bytes.hasBeenDestroyed;

  StateError _destroyedError() => StateError('$this has been destroyed.');
}
