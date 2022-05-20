import 'dart:async';

import 'package:cryptography/cryptography.dart';
import 'package:solana/src/crypto/ed25519_hd_public_key.dart';

class Ed25519HDKeyPairData implements KeyPairData {
  Ed25519HDKeyPairData(
    this.bytes, {
    required FutureOr<Ed25519HDPublicKey> publicKey,
  }) : _publicKey = publicKey;

  final List<int> bytes;

  final FutureOr<Ed25519HDPublicKey> _publicKey;

  @override
  // ignore: use_to_and_as_if_applicable, overridden method
  Future<Ed25519HDKeyPairData> extract() => Future.value(this);

  @override
  Future<Ed25519HDPublicKey> extractPublicKey() async => _publicKey;

  @override
  KeyPairType<KeyPairData, PublicKey> get type => KeyPairType.ed25519;
}
