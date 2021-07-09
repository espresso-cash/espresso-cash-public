import 'dart:typed_data';

import 'package:solana/src/borsh_serializer/borsh_serializer.dart';

/// Serializes an integer using the Borsh serialization
/// which for integers is simply the bytes in little endian
/// order.
class BorshInteger implements BorshSerializable<int> {
  const BorshInteger._(this._data);
  factory BorshInteger._unsigned(int value, int bitSize) {
    if (bitSize % _bitsPerByte != 0) {
      throw ArgumentError(
          'invalid bit size $bitSize, must be multiple of $_bitsPerByte');
    }

    final data = ByteData(bitSize ~/ _bitsPerByte);
    switch (bitSize) {
      case 8:
        data.setUint8(0, value);
        break;
      case 16:
        data.setUint16(0, value, Endian.little);
        break;
      case 32:
        data.setUint32(0, value, Endian.little);
        break;
      case 64:
        data.setUint64(0, value, Endian.little);
        break;
    }

    return BorshInteger._(data.buffer.asUint8List());
  }

  factory BorshInteger._signed(int value, int bitSize) {
    if (bitSize % _bitsPerByte != 0) {
      throw ArgumentError(
          'invalid bit size $bitSize, must be multiple of $_bitsPerByte');
    }

    final data = ByteData(bitSize ~/ _bitsPerByte);
    switch (bitSize) {
      case 8:
        data.setInt8(0, value);
        break;
      case 16:
        data.setInt16(0, value, Endian.little);
        break;
      case 32:
        data.setInt32(0, value, Endian.little);
        break;
      case 64:
        data.setInt64(0, value, Endian.little);
        break;
    }

    return BorshInteger._(data.buffer.asUint8List());
  }

  /// Create a u8 from [value]
  factory BorshInteger.u8(int value) => BorshInteger._unsigned(value, 8);

  /// Create a i8 from [value]
  factory BorshInteger.i8(int value) => BorshInteger._signed(value, 8);

  /// Create a u16 from [value]
  factory BorshInteger.u16(int value) => BorshInteger._unsigned(value, 16);

  /// Create a i16 from [value]
  factory BorshInteger.i16(int value) => BorshInteger._signed(value, 16);

  /// Create a u32 from [value]
  factory BorshInteger.u32(int value) => BorshInteger._unsigned(value, 32);

  /// Create a i32 from [value]
  factory BorshInteger.i32(int value) => BorshInteger._signed(value, 32);

  /// Create a u64 from [value]
  factory BorshInteger.u64(int value) => BorshInteger._unsigned(value, 64);

  /// Create a i64 from [value]
  factory BorshInteger.i64(int value) => BorshInteger._signed(value, 64);

  final Uint8List _data;

  @override
  int deserialize(Uint8List data) => 0;

  @override
  Uint8List serialize() => _data;
}

const int _bitsPerByte = 8;
