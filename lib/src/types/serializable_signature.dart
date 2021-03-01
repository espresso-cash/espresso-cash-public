import 'package:crypto_please_solana_lib/src/types/serializable.dart';
import 'package:cryptography/cryptography.dart';

class SerializableSignature extends Serializable {
  SerializableSignature.from(Signature signature) : _bytes = signature.bytes;

  List<int> _bytes;

  @override
  List<int> serialize() {
    return _bytes;
  }
}
