part of 'encoder.dart';

const int _bitsPerByte = 8;
const int _hexCharsPerByte = 2;

// TODO(IA): we probably need unsigned versions of integers as well
class Buffer extends ByteArray {
  Buffer._(this._data) : super();

  factory Buffer._fromIterable(ByteArray iterable) =>
      Buffer._([for (int i in iterable) i]);

  factory Buffer._fromIntWithBitSize(
    int value, {
    required int bitSize,
  }) {
    final String padded = value.toRadixString(16).padLeft(
          _hexCharsPerByte * bitSize ~/ _bitsPerByte,
          '0',
        );
    final List<int> be = hex.decode(padded);
    // Convert to LE
    return Buffer._fromIterable(be.reversed);
  }

  factory Buffer.fromUInt8(int value) =>
      Buffer._fromIntWithBitSize(value, bitSize: 8);

  factory Buffer.fromInt8(int value) =>
      Buffer._fromIntWithBitSize(value, bitSize: 8);

  factory Buffer.fromInt32(int value) =>
      Buffer._fromIntWithBitSize(value, bitSize: 32);

  factory Buffer.fromInt64(int value) =>
      Buffer._fromIntWithBitSize(value, bitSize: 64);

  factory Buffer.fromString(String string) => Buffer._(utf8.encode(string));

  factory Buffer.fromByteArrays(Iterable<ByteArray> byteArrays) => Buffer._(
        byteArrays.fold([], (combined, buffer) => [...combined, ...buffer]),
      );

  final ByteArray _data;

  @override
  Iterator<int> get iterator => _data.iterator;
}
