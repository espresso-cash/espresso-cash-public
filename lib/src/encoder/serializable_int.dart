part of 'encoder.dart';

const int _bitsPerByte = 8;
const int _hexCharsPerByte = 2;

class SerializableInt extends Iterable<int> {
  SerializableInt._(this._data) : super();

  factory SerializableInt._fromIterable(Iterable<int> iterable) =>
      SerializableInt._([for (int i in iterable) i]);

  factory SerializableInt.from(int value, {int bitSize = 8}) {
    final String padded = value.toRadixString(16).padLeft(
          _hexCharsPerByte * bitSize ~/ _bitsPerByte,
          '0',
        );
    final List<int> be = hex.decode(padded);
    // Convert to LE
    return SerializableInt._fromIterable(be.reversed);
  }

  final Iterable<int> _data;

  @override
  Iterator<int> get iterator => _data.iterator;
}
