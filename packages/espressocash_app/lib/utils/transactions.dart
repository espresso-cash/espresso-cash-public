import 'package:solana/solana.dart';

extension Ed25519HDPublicKeyExt on Ed25519HDPublicKey {
  Signature emptySignature() => Signature(List.filled(64, 0), publicKey: this);
}
