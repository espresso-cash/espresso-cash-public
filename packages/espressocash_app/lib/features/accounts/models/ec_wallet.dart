import 'package:flutter/foundation.dart';
import 'package:solana/solana.dart';

abstract class ECWallet {
  const ECWallet();

  String get address;

  Ed25519HDPublicKey get publicKey;

  Future<List<Signature>> sign(Iterable<Uint8List> payloads);
}

class LocalWallet implements ECWallet {
  const LocalWallet(this.keyPair);

  final Ed25519HDKeyPair keyPair;

  @override
  String get address => keyPair.address;

  @override
  Ed25519HDPublicKey get publicKey => keyPair.publicKey;

  @override
  Future<List<Signature>> sign(Iterable<Uint8List> payloads) =>
      Future.wait(payloads.map(keyPair.sign));
}
