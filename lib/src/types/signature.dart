import 'package:cryptography/cryptography.dart' as crypto;
import 'package:solana_dart/src/types/serializable.dart';

class Signature extends Serializable {
  Signature.from(crypto.Signature signature) : _bytes = signature.bytes;

  List<int> _bytes;

  @override
  List<int> serialize() {
    return _bytes;
  }
}
