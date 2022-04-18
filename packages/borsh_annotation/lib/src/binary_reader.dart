import 'dart:convert';
import 'dart:typed_data';

class BinaryReader {
  BinaryReader(this.buf);

  int offset = 0;
  ByteData buf;

  int readU8() {
    final value = buf.getUint8(offset);
    offset += 1;

    return value;
  }

  int readU16() {
    final value = buf.getUint16(offset, Endian.little);
    offset += 2;

    return value;
  }

  int readU32() {
    final value = buf.getUint32(offset, Endian.little);
    offset += 4;

    return value;
  }

  BigInt readU64() {
    // TODO(KB): won't work for big numbers, update implementation
    final value = buf.getUint64(offset, Endian.little);
    offset += 8;

    return BigInt.from(value);
  }

  List<int> _readBuffer(int len) {
    if (offset + len > buf.lengthInBytes) {
      throw RangeError('Buffer overflow');
    }
    final buffer = buf.buffer.asUint8List().sublist(offset, offset + len);
    offset += len;

    return buffer;
  }

  String readString() {
    final len = readU32();
    final buffer = _readBuffer(len);

    return utf8.decode(buffer);
  }

  List<T> readFixedArray<T>(int len, T Function() fn) {
    final result = <T>[];
    for (int i = 0; i < len; i++) {
      result.add(fn());
    }

    return result;
  }

  List<T> readArray<T>(T Function() fn) {
    final len = readU32();
    final result = <T>[];
    for (int i = 0; i < len; i++) {
      result.add(fn());
    }

    return result;
  }
}
