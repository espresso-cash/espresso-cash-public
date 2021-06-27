part of 'encoder.dart';

class _CompactArray<T> extends ByteArray {
  const _CompactArray(this._data);

  factory _CompactArray._fromLengthAndContent(
          ByteArray length, ByteArray content) =>
      _CompactArray(Buffer.fromConcatenatedByteArrays([length, content]));

  factory _CompactArray.fromIterable(Iterable<T> items) {
    final mapped = items.map<ByteArray>(_getBytesOf);
    final length = _CompactU16(mapped.length);
    if (mapped.isEmpty) {
      return _CompactArray(length);
    }
    return _CompactArray._fromLengthAndContent(length, mapped.reduce(_merge));
  }

  final ByteArray _data;

  @override
  Iterator<int> get iterator => _data.iterator;
}

ByteArray _merge(ByteArray values, ByteArray next) =>
    Buffer.fromConcatenatedByteArrays([values, next]);

ByteArray _getBytesOf<T>(T value) {
  if (value is ByteArray) {
    return value;
  } else if (value is int) {
    return Buffer.fromInt8(value);
  } else {
    throw FormatException('cannot serialize $value');
  }
}
