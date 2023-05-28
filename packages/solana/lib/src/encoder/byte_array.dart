import 'dart:convert';
import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/base58.dart';

@immutable
class ByteArray extends Iterable<int> {
  ByteArray(Iterable<int> data)
      : assert(
          data.every((e) => e < 256),
          'All elements should be less than 256',
        ),
        _data = data.toList();

  const ByteArray._(this._data);

  const ByteArray.empty() : this._(const []);

  ByteArray._fromByteData(ByteData data) : _data = data.buffer.asUint8List();

  factory ByteArray.merge(Iterable<ByteArray> arrays) {
    final list = Uint8List.fromList(arrays.expand((e) => e).toList());

    return ByteArray(list);
  }

  factory ByteArray.fromBase58(String base58String) =>
      ByteArray(Uint8List.fromList(base58decode(base58String)));

  factory ByteArray.fromString(String string) => ByteArray.merge([
        ByteArray.u64(string.length),
        ByteArray(utf8.encode(string)),
      ]);

  factory ByteArray.i8(int value) =>
      ByteArray._fromByteData(ByteData(1)..setUint8(0, value));

  factory ByteArray.u8(int value) =>
      ByteArray._fromByteData(ByteData(1)..setUint8(0, value));

  factory ByteArray.i16(int value) =>
      ByteArray._fromByteData(ByteData(2)..setUint16(0, value, Endian.little));

  factory ByteArray.u16(int value) =>
      ByteArray._fromByteData(ByteData(2)..setUint16(0, value, Endian.little));

  factory ByteArray.i32(int value) =>
      ByteArray._fromByteData(ByteData(4)..setUint32(0, value, Endian.little));

  factory ByteArray.u32(int value) =>
      ByteArray._fromByteData(ByteData(4)..setUint32(0, value, Endian.little));

  factory ByteArray.i64(int value) => _encodeBigInt(BigInt.from(value), 8);

  factory ByteArray.u64(int value) =>
      _encodeBigIntAsUnsigned(BigInt.from(value), 8);

  final List<int> _data;

  @override
  Iterator<int> get iterator => _data.iterator;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ByteArray &&
          const ListEquality<int>().equals(_data, other._data));

  @override
  int get hashCode => const ListEquality<int>().hash(_data);
}

ByteArray _encodeBigInt(BigInt number, int s) {
  if (number == BigInt.zero) {
    return ByteArray(List.filled(s, 0));
  }

  final result = Uint8List(s);
  for (var i = 0; i < s; i++) {
    result[i] = (number & _byteMask).toInt();
    number = number >> 8;
  }

  return ByteArray(result);
}

ByteArray _encodeBigIntAsUnsigned(BigInt number, int s) {
  if (number == BigInt.zero) {
    return ByteArray(List.filled(s, 0));
  }

  final result = Uint8List(s);
  for (var i = 0; i < s; i++) {
    result[i] = (number & _byteMask).toInt();
    number = number >> 8;
  }

  return ByteArray(result);
}

final _byteMask = BigInt.from(0xff);
