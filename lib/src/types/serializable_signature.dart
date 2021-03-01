import 'package:cryptography/cryptography.dart';
import 'package:solana_dart/src/types/serializable.dart';

class SerializableSignature extends Serializable {
  SerializableSignature.from(Signature signature) : _bytes = signature.bytes;

  List<int> _bytes;

  @override
  List<int> serialize() {
    return _bytes;
  }
}
