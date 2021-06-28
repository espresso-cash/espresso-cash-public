part of 'encoder.dart';

class _CompactArray extends ByteArray {
  const _CompactArray(this._data);

  factory _CompactArray._fromLengthAndContent(
          ByteArray length, ByteArray content) =>
      _CompactArray(Buffer.fromConcatenatedByteArrays([length, content]));

  factory _CompactArray.fromIterable(Iterable<Object> items) {
    final mapped = items.map<ByteArray>(_CompactArray._getBytesOf);
    final length = _CompactU16(mapped.length);
    if (mapped.isEmpty) {
      return _CompactArray(length);
    }
    return _CompactArray._fromLengthAndContent(length, mapped.reduce(_merge));
  }

  static ByteArray _merge(ByteArray values, ByteArray next) =>
      Buffer.fromConcatenatedByteArrays([values, next]);

  static ByteArray _getBytesOf(Object value) {
    if (value is ByteArray) {
      return value;
    } else if (value is int) {
      return Buffer.fromInt8(value);
    } else {
      throw FormatException('cannot serialize $value');
    }
  }

  final ByteArray _data;

  @override
  Iterator<int> get iterator => _data.iterator;
}
