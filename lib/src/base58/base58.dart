library base58;

import 'dart:convert';

const String _base58Alphabet =
    '123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz';
const List<int> _reverseMap = [
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  0,
  1,
  2,
  3,
  4,
  5,
  6,
  7,
  8,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  9,
  10,
  11,
  12,
  13,
  14,
  15,
  16,
  -1,
  17,
  18,
  19,
  20,
  21,
  -1,
  22,
  23,
  24,
  25,
  26,
  27,
  28,
  29,
  30,
  31,
  32,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  33,
  34,
  35,
  36,
  37,
  38,
  39,
  40,
  41,
  42,
  43,
  -1,
  44,
  45,
  46,
  47,
  48,
  49,
  50,
  51,
  52,
  53,
  54,
  55,
  56,
  57,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1
];

// Base58 encode the byte array [bytes]
//
// Note: Taken from https://github.com/bitcoin/bitcoin/blob/master/src/base58.cpp
//       and adapted to the dart language
String encode(List<int> bytes) {
  int zeroes = 0;
  int length = 0;
  String encoded = '';
  if (bytes.length == 0) return encoded;
  // Count zeroes
  for (; zeroes < bytes.length && bytes[zeroes] == 0; zeroes++);
  // Compute final size
  int size = (bytes.length - zeroes) * 138 ~/ 100 + 1;
  // Create temporary storage
  List<int> b58bytes = List<int>.filled(size, 0);
  for (int byteValue in bytes.sublist(zeroes)) {
    int carry = byteValue;
    int i = 0;
    for (int j = 0; j < size; j++, i++) {
      if (!((carry != 0) || (i < length))) break;
      carry += 256 * b58bytes[j];
      b58bytes[j] = carry % 58;
      carry ~/= 58;
    }
    length = i;
  }
  List<int> finalBytes = b58bytes.sublist(0, length);
  for (int byte in finalBytes) {
    encoded = _base58Alphabet[byte] + encoded;
  }
  encoded = '1' * zeroes + encoded;
  return encoded;
}

List<int> decode(String value) {
  String trimmed = value.trim();
  if (trimmed.length == 0) return [];
  int zeroes = 0;
  int length = 0;
  for (; zeroes < trimmed.length && trimmed[zeroes] == '1'; zeroes++);
  int size = (trimmed.length - zeroes) * 733 ~/ 1000 + 1;
  List<int> bytes256 = List.filled(size, 0);
  List<int> inputBytes = utf8.encode(trimmed);
  for (int currentByte in inputBytes) {
    int carry = _reverseMap[currentByte];
    int i = 0;
    if (carry == -1) throw ('invalid base58 character found ${currentByte}');
    for (int j = size - 1; j >= 0; j--, i++) {
      if (!((carry != 0) || (i < length))) break;
      carry += 58 * bytes256[j];
      bytes256[j] = carry % 256;
      carry ~/= 256;
    }
    length = i;
  }
  return [...List<int>.filled(zeroes, 0), ...bytes256.sublist(size - length)];
}
