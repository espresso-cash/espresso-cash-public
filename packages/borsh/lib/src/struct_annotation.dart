import 'dart:typed_data';

import 'package:borsh/src/type.dart';

class Struct {
  const Struct({
    this.createFromBorsh = true,
    this.createToBorsh = true,
  });

  final bool createToBorsh;
  final bool createFromBorsh;
}

extension IOExt on ByteData {
  int writeInteger(Borsh type, int offset, int value) {
    switch (type) {
      case Borsh.u8:
        setUint8(offset, value);
        return 1;
      case Borsh.u16:
        setUint16(offset, value, Endian.little);
        return 2;
      case Borsh.u32:
        setUint32(offset, value, Endian.little);
        return 4;
      case Borsh.u64:
        setUint64(offset, value, Endian.little);
        return 8;
      case Borsh.i8:
        setInt8(offset, value);
        return 1;
      case Borsh.i16:
        setInt16(offset, value, Endian.little);
        return 2;
      case Borsh.i32:
        setInt32(offset, value, Endian.little);
        return 4;
      case Borsh.i64:
        setInt64(offset, value, Endian.little);
        return 8;
      case Borsh.string:
      case Borsh.array:
      case Borsh.struct:
      case Borsh.dynamicArray:
      case Borsh.invalid:
        // If this happens, it means something is wrong
        // with the generator itself
        throw ArgumentError('$type is not a primitive');
    }
  }

  int writeString(int offset, String value) {
    int currentPosition = offset;
    final bytes = value.codeUnits;
    // Write the length
    setUint32(offset, value.length, Endian.little);
    currentPosition += 4;

    // Write each character
    bytes.forEach((b) => setUint8(currentPosition++, b));

    return 4 + value.length;
  }

  int writeFixedArray<T>(Borsh type, int offset, List<T> list) {
    int sizeInBytes = 0;
    for (final item in list) {
      switch (type) {
        case Borsh.u8:
        case Borsh.u16:
        case Borsh.u32:
        case Borsh.u64:
        case Borsh.i8:
        case Borsh.i16:
        case Borsh.i32:
        case Borsh.i64:
          if (item is! int) {
            throw ArgumentError('expecting an array of int but it is of $T');
          }
          sizeInBytes += writeInteger(type, sizeInBytes + offset, item);
          break;
        case Borsh.string:
          if (item is! String) {
            throw ArgumentError('expecting an array of String but it is of $T');
          }
          sizeInBytes += writeString(sizeInBytes + offset, item);
          break;
        case Borsh.array:
          break;
        case Borsh.struct:
          break;
        case Borsh.dynamicArray:
          break;
        case Borsh.invalid:
          break;
      }
    }
    return sizeInBytes;
  }

  int writeDynamicArray<T>(Borsh type, int offset, List<T> list) {
    setUint32(offset, list.length, Endian.little);
    return 4 + writeFixedArray(type, offset + 4, list);
  }

  T readInteger<T>(Borsh type, int offset) {
    switch (type) {
      case Borsh.u8:
        return getUint8(offset) as T;
      case Borsh.u16:
        return getUint16(offset, Endian.little) as T;
      case Borsh.u32:
        return getUint32(offset, Endian.little) as T;
      case Borsh.u64:
        return getUint64(offset, Endian.little) as T;
      case Borsh.i8:
        return getInt8(offset) as T;
      case Borsh.i16:
        return getInt16(offset, Endian.little) as T;
      case Borsh.i32:
        return getInt32(offset, Endian.little) as T;
      case Borsh.i64:
        return getInt64(offset, Endian.little) as T;
      case Borsh.string:
      case Borsh.array:
      case Borsh.struct:
      case Borsh.dynamicArray:
      case Borsh.invalid:
        // If this happens, it means something is wrong
        // with the generator itself
        throw ArgumentError('$type is not a primitive');
    }
  }

  String readString(int offset) {
    final int length = getUint32(offset, Endian.little);

    return String.fromCharCodes(
      buffer.asUint8List(offset + 4, length),
    );
  }

  List<T> readFixedArray<T>(Borsh type, int length, int offset) {
    final List<T> list = [];
    int currentOffset = offset;
    for (int index = 0; index < length; ++index) {
      late final int itemSize;
      switch (type) {
        case Borsh.u8:
          list.add(readInteger(type, currentOffset));
          itemSize = 1;
          break;
        case Borsh.i8:
          list.add(readInteger(type, currentOffset));
          itemSize = 1;
          break;
        case Borsh.u16:
          list.add(readInteger(type, currentOffset));
          itemSize = 2;
          break;
        case Borsh.i16:
          list.add(readInteger(type, currentOffset));
          itemSize = 2;
          break;
        case Borsh.u32:
          list.add(readInteger(type, currentOffset));
          itemSize = 4;
          break;
        case Borsh.i32:
          list.add(readInteger(type, currentOffset));
          itemSize = 4;
          break;
        case Borsh.u64:
          list.add(readInteger(type, currentOffset));
          itemSize = 8;
          break;
        case Borsh.i64:
          list.add(readInteger(type, currentOffset));
          itemSize = 8;
          break;
        case Borsh.string:
          final string = readString(currentOffset);
          itemSize = 4 + string.length;
          list.add(string as T);
          break;
        case Borsh.array:
        case Borsh.dynamicArray:
          throw UnimplementedError('nested arrays');
        case Borsh.struct:
          throw UnimplementedError('array of structs');
        case Borsh.invalid:
          throw ArgumentError('invalid type is not serializable');
      }
      currentOffset += itemSize;
    }
    return list;
  }

  List<T> readDynamicArray<T>(Borsh type, int offset) {
    final int length = getUint32(offset, Endian.little);
    return readFixedArray<T>(type, length, offset + 4);
  }
}
