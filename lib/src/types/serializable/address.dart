import 'package:solana/src/base58/base58.dart' as base58;

class SerializablePubKey extends Iterable<int> {
  SerializablePubKey._(this._data);

  factory SerializablePubKey.from(String address) =>
      SerializablePubKey._(base58.decode(address));

  final Iterable<int> _data;

  @override
  Iterator<int> get iterator => _data.iterator;
}
