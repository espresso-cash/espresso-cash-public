import 'package:convert/convert.dart';

const int _BITS_PER_BYTE = 8;
const int _HEX_CHARS_PER_BYTE = 2;

String _padTo(String what, String character, int length) {
  return what.padLeft(length, character);
}

List<int> encodeInt(int value, [int bitSize = 8]) {
  String padded = _padTo(
    value.toRadixString(16),
    '0',
    _HEX_CHARS_PER_BYTE * bitSize ~/ _BITS_PER_BYTE,
  );
  List<int> be = hex.decode(padded);
  // Convert to LE
  return List.from(be.reversed);
}
