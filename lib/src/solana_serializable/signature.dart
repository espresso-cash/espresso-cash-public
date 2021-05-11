import 'package:cryptography/cryptography.dart' as crypto;
import 'package:solana/src/solana_serializable/solana_serializable.dart';

class Signature extends Serializable {
  Signature.from(crypto.Signature signature) : _bytes = signature.bytes;

  final List<int> _bytes;

  @override
  List<int> serialize() => _bytes;
}
