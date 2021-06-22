part of 'encoder.dart';

class SerializablePubKey extends Iterable<int> {
  SerializablePubKey._(this._data);

  factory SerializablePubKey.from(String address) =>
      SerializablePubKey._(base58.decode(address));

  final Iterable<int> _data;

  @override
  Iterator<int> get iterator => _data.iterator;
}
