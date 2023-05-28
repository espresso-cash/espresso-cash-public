import 'dart:convert';
import 'dart:typed_data';

class BinaryWriter {
  BinaryWriter();

  ByteData buf = ByteData(_initialLength);
  int length = 0;

  void _maybeResize() {
    if (buf.lengthInBytes >= 16 + length) return;

    final list = Uint8List.fromList([
      ...buf.buffer.asUint8List(),
      ...Uint8List(_initialLength),
    ]);
    buf = list.buffer.asByteData();
  }

  void writeU8(int value) {
    _maybeResize();
    buf.setUint8(length, value);
    length += 1;
  }

  void writeU16(int value) {
    _maybeResize();
    buf.setUint16(length, value, Endian.little);
    length += 2;
  }

  void writeU32(int value) {
    _maybeResize();
    buf.setUint32(length, value, Endian.little);
    length += 4;
  }

  void writeU64(BigInt value) {
    final buffer = _encodeBigIntAsUnsigned(value, 8);
    _writeBuffer(buffer);
  }

  void _writeBuffer(Iterable<int> buffer) {
    final list = Uint8List.fromList([
      ...buf.buffer.asUint8List().take(length),
      ...buffer,
      ...Uint8List(_initialLength),
    ]);
    buf = list.buffer.asByteData();
    length += buffer.length;
  }

  void writeString(String value) {
    final buffer = utf8.encode(value);
    writeU32(buffer.length);
    _writeBuffer(buffer);
  }

  void writeFixedArray<T>(Iterable<T> array, void Function(T item) fn) {
    for (final item in array) {
      fn(item);
    }
  }

  void writeArray<T>(Iterable<T> array, void Function(T item) fn) {
    writeU32(array.length);
    for (final item in array) {
      fn(item);
    }
  }

  void writeStruct(Uint8List struct) => _writeBuffer(struct);

  Uint8List toArray() => buf.buffer.asUint8List().sublist(0, length);
}

const _initialLength = 1024;

Iterable<int> _encodeBigIntAsUnsigned(BigInt number, int s) {
  if (number == BigInt.zero) {
    return List.filled(s, 0);
  }

  final result = Uint8List(s);
  for (var i = 0; i < s; i++) {
    result[i] = (number & _byteMask).toInt();
    number = number >> 8;
  }

  return result;
}

final _byteMask = BigInt.from(0xff);
