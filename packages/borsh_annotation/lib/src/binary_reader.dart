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
    final buffer = _readBuffer(8);

    return _decodeBigInt(buffer, isSigned: false);
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

BigInt _decodeBigInt(Iterable<int> bytes, {required bool isSigned}) {
  final list = bytes.toList();

  final negative = isSigned
      ? list.isNotEmpty && list.last & _negativeFlag == _negativeFlag
      : false;

  BigInt result;

  if (list.length == 1) {
    result = BigInt.from(list.first);
  } else {
    result = BigInt.zero;
    for (var i = 0; i < list.length; i++) {
      final item = list[i];
      result |= BigInt.from(item) << (8 * i);
    }
  }

  return result != BigInt.zero
      ? negative
          ? result.toSigned(result.bitLength)
          : result
      : BigInt.zero;
}

const _negativeFlag = 0x80;
