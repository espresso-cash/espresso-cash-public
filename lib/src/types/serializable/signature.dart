import 'package:cryptography/cryptography.dart' as crypto;

class Signature extends Iterable<int> {
  Signature.from(crypto.Signature signature) : _data = signature.bytes;

  final Iterable<int> _data;

  @override
  Iterator<int> get iterator => _data.iterator;
}
