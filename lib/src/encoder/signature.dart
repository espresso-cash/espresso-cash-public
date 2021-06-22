part of 'encoder.dart';

class Signature extends ByteArray {
  Signature.from(crypto.Signature signature) : _data = signature.bytes;

  final ByteArray _data;

  @override
  Iterator<int> get iterator => _data.iterator;
}
