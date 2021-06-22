part of 'encoder.dart';

class PubKeyBytes extends ByteArray {
  PubKeyBytes._(this._data);

  factory PubKeyBytes.from(String address) =>
      PubKeyBytes._(base58.decode(address));

  final ByteArray _data;

  @override
  Iterator<int> get iterator => _data.iterator;
}
