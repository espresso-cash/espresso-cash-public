part of 'encoder.dart';

class PubKeyBytes extends Iterable<int> {
  PubKeyBytes._(this._data);

  factory PubKeyBytes.from(String address) =>
      PubKeyBytes._(base58.decode(address));

  final Iterable<int> _data;

  @override
  Iterator<int> get iterator => _data.iterator;
}
