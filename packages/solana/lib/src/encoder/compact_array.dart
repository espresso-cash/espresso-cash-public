import 'package:solana/src/common/byte_array.dart';
import 'package:solana/src/encoder/buffer.dart';
import 'package:solana/src/encoder/compact_u16.dart';

class CompactArray extends ByteArray {
  const CompactArray(this._data);

  const CompactArray.empty() : _data = CompactU16.zero;

  factory CompactArray._fromLengthAndContent(
    ByteArray length,
    ByteArray content,
  ) =>
      CompactArray(Buffer.fromConcatenatedByteArrays([length, content]));

  factory CompactArray.fromIterable(Iterable<Object> items) {
    final mapped = items.map<ByteArray>(CompactArray._getBytesOf);
    final length = CompactU16(mapped.length);
    if (mapped.isEmpty) {
      return const CompactArray.empty();
    }
    return CompactArray._fromLengthAndContent(length, mapped.reduce(_merge));
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
