import 'package:cryptography/cryptography.dart';
import 'package:solana/base58.dart';

export 'package:cryptography/cryptography.dart' show Signature;

extension SignatureExt on Signature {
  String toBase58() => base58encode(bytes.toList(growable: false));
}
