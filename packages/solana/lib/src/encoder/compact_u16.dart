import 'package:solana/src/common/byte_array.dart';

class CompactU16 extends ByteArray {
  factory CompactU16(int value) {
    final List<int> data = List<int>.empty(growable: true);
    int rawValue = value;
    while (rawValue != 0) {
      final int currentByte = rawValue & 0x7f;
      rawValue >>= 7;
      if (rawValue == 0) {
        data.add(currentByte);
      } else {
        data.add(currentByte | 0x80);
      }
    }
    return CompactU16._(data);
  }

  const CompactU16._(this._data);
  static const zero = CompactU16._([0]);

  final ByteArray _data;

  @override
  Iterator<int> get iterator => _data.iterator;
}
