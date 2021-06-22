part of 'encoder.dart';

class CompactArray<T> extends Iterable<int> {
  // const CompactArray.fromIterable(this._items);

  // final Iterable<T> _items;
  const CompactArray(this._data);

  factory CompactArray._fromLengthAndContent(
          Iterable<int> length, Iterable<int> content) =>
      CompactArray(Buffer.fromByteArrays([length, content]));

  const CompactArray.empty() : _data = const Iterable<int>.empty();

  factory CompactArray.fromIterable(Iterable<T> items) {
    final mapped = items.map<Iterable<int>>(_getBytesOf);
    final length = CompactU16(mapped.length);
    if (mapped.isEmpty) {
      return CompactArray(length);
    }
    return CompactArray._fromLengthAndContent(length, mapped.reduce(_merge));
  }

  final Iterable<int> _data;

  @override
  Iterator<int> get iterator => _data.iterator;
}

Iterable<int> _merge(Iterable<int> values, Iterable<int> next) =>
    Buffer.fromByteArrays([values, next]);

Iterable<int> _getBytesOf<T>(T value) {
  if (value is Iterable<int>) {
    return value;
  } else if (value is int) {
    return Buffer.fromInt8(value);
  } else {
    throw FormatException('cannot serialize $value');
  }
}
