import 'package:cryptography/cryptography.dart' as crypto;
import 'package:solana/src/common/byte_array.dart';

class Signature extends ByteArray {
  Signature.from(crypto.Signature signature) : _data = signature.bytes;

  final ByteArray _data;

  @override
  Iterator<int> get iterator => _data.iterator;
}
