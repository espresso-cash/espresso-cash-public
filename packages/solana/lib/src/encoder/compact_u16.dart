import 'dart:typed_data';

import 'package:solana/src/encoder/byte_array.dart';

class CompactU16 {
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

    return CompactU16.raw(data);
  }

  const CompactU16.raw(this._data);

  static const zero = CompactU16.raw([0]);

  final List<int> _data;

  int get value {
    var len = 0;
    var size = 0;
    for (final elem in _data) {
      len |= (elem & 0x7f) << (size * 7);
      size += 1;
      if ((elem & 0x80) == 0) {
        break;
      }
    }

    return len;
  }

  ByteArray toByteArray() => ByteArray(Uint8List.fromList(_data));
}
