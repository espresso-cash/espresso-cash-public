import 'dart:convert';
import 'dart:typed_data';

import 'package:solana/src/base58/decode.dart';
import 'package:solana/src/common/byte_array.dart';

const int _bitsPerByte = 8;

/// Convenient way of building a buffer for a message
class Buffer extends ByteArray {
  const Buffer._(this._data) : super();

  factory Buffer._fromIntWithBitSize(
    int value, {
    required int bitSize,
    bool unsigned = false,
  }) {
    final data = ByteData(bitSize ~/ _bitsPerByte);
    switch (bitSize) {
      case 8:
        if (unsigned) {
          data.setUint8(0, value);
        } else {
          data.setInt8(0, value);
        }
        break;
      case 16:
        if (unsigned) {
          data.setUint16(0, value, Endian.little);
        } else {
          data.setInt16(0, value, Endian.little);
        }
        break;
      case 32:
        if (unsigned) {
          data.setUint32(0, value, Endian.little);
        } else {
          data.setInt32(0, value, Endian.little);
        }
        break;
      case 64:
        if (unsigned) {
          data.setUint64(0, value, Endian.little);
        } else {
          data.setInt64(0, value, Endian.little);
        }
        break;
      default:
        throw FormatException('invalid bit size $bitSize');
    }
    return Buffer._(Uint8List.view(data.buffer));
  }

  factory Buffer.fromUint8(int value) =>
      Buffer._fromIntWithBitSize(value, bitSize: 8, unsigned: true);

  factory Buffer.fromInt8(int value) =>
      Buffer._fromIntWithBitSize(value, bitSize: 8);

  factory Buffer.fromUint32(int value) =>
      Buffer._fromIntWithBitSize(value, bitSize: 32, unsigned: true);

  factory Buffer.fromInt32(int value) =>
      Buffer._fromIntWithBitSize(value, bitSize: 32);

  factory Buffer.fromUint64(int value) =>
      Buffer._fromIntWithBitSize(value, bitSize: 64, unsigned: true);

  factory Buffer.fromInt64(int value) =>
      Buffer._fromIntWithBitSize(value, bitSize: 64);

  Buffer.fromString(String string) : _data = utf8.encode(string);

  Buffer.fromConcatenatedByteArrays(Iterable<ByteArray> byteArrays)
      : _data = byteArrays.fold(
          [],
          (concatenated, buffer) => concatenated.followedBy(buffer),
        );

  Buffer.fromBase58(String base58String) : _data = base58decode(base58String);

  final Iterable<int> _data;

  @override
  Iterator<int> get iterator => _data.iterator;
}
