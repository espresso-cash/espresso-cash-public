import 'package:solana/src/common/byte_array.dart';
import 'package:solana/src/encoder/compact_u16.dart';

class CompactArray {
  CompactArray(this._data);

  final ByteArray _data;

  ByteArray toByteArray() {
    final length = CompactU16(_data.length);

    return ByteArray.merge([length.toByteArray(), _data]);
  }
}
