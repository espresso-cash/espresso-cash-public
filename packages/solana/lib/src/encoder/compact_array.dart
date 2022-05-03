import 'package:solana/src/encoder/byte_array.dart';
import 'package:solana/src/encoder/compact_u16.dart';

class CompactArray {
  CompactArray(this._data) : _length = CompactU16(_data.length);

  CompactArray.fromIterable(Iterable<ByteArray> data)
      : _data = ByteArray.merge(data),
        _length = CompactU16(data.length);

  final ByteArray _data;
  final CompactU16 _length;

  ByteArray toByteArray() => ByteArray.merge([_length.toByteArray(), _data]);
}
