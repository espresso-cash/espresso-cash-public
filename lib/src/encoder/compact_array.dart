part of 'encoder.dart';

class CompactArray<T> extends ByteArray {
  // const CompactArray.fromIterable(this._items);

  // final Iterable<T> _items;
  const CompactArray(this._data);

  factory CompactArray._fromLengthAndContent(
          ByteArray length, ByteArray content) =>
      CompactArray(Buffer.fromByteArrays([length, content]));

  const CompactArray.empty() : _data = const ByteArray.empty();

  factory CompactArray.fromIterable(Iterable<T> items) {
    final mapped = items.map<ByteArray>(_getBytesOf);
    final length = CompactU16(mapped.length);
    if (mapped.isEmpty) {
      return CompactArray(length);
    }
    return CompactArray._fromLengthAndContent(length, mapped.reduce(_merge));
  }

  final ByteArray _data;

  @override
  Iterator<int> get iterator => _data.iterator;
}

ByteArray _merge(ByteArray values, ByteArray next) =>
    Buffer.fromByteArrays([values, next]);

ByteArray _getBytesOf<T>(T value) {
  if (value is ByteArray) {
    return value;
  } else if (value is int) {
    return Buffer.fromInt8(value);
  } else {
    throw FormatException('cannot serialize $value');
  }
}
