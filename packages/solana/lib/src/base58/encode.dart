part 'base58_alphabet.dart';

// Base58 encode the byte array [bytes]
//
// Note: Taken from https://github.com/bitcoin/bitcoin/blob/master/src/base58.cpp
//       and adapted to the dart language
String base58encode(List<int> bytes) {
  String encoded = '';
  if (bytes.isEmpty) return encoded;
  final zeroes = bytes.takeWhile((v) => v == 0).length;
  int length = 0;
  // Compute final size
  final size = (bytes.length - zeroes) * 138 ~/ 100 + 1;
  // Create temporary storage
  final List<int> b58bytes = List<int>.filled(size, 0);
  for (final byteValue in bytes.skip(zeroes)) {
    int carry = byteValue;
    int i = 0;
    for (int j = 0; j < size; j++, i++) {
      // ignore: avoid-inverted-boolean-checks, fix later
      if (!((carry != 0) || (i < length))) break;
      carry += 256 * b58bytes[j];
      b58bytes[j] = carry % 58;
      carry ~/= 58;
    }
    length = i;
  }
  final List<int> finalBytes = b58bytes.sublist(0, length);
  for (final byte in finalBytes) {
    encoded = _base58Alphabet[byte] + encoded;
  }

  return '1' * zeroes + encoded;
}
