import 'dart:collection';

import 'package:convert/convert.dart';
import 'package:solana/src/solana_serializable/solana_serializable.dart';

const int _bitsPerByte = 8;
const int _hexCharsPerByte = 2;

class SerializableInt extends ListBase<int> implements Serializable {
  SerializableInt._(this._values) : length = _values.length;

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

  final List<int> _values;

  @override
  int length = 0;

  @override
  int operator [](int index) => _values[index];

  @override
  void operator []=(int index, int value) {
    _values[index] = value;
  }

  @override
  List<int> serialize() => _values;
}
