part of 'base58.dart';

List<int> decode(String value) {
  final trimmed = value.trim();
  if (trimmed.isEmpty) return [];

  int length = 0;
  final zeroes = trimmed.split('').takeWhile((v) => v == '1').length;

  final size = (trimmed.length - zeroes) * 733 ~/ 1000 + 1;
  final bytes256 = List.filled(size, 0);
  final List<int> inputBytes = utf8.encode(trimmed);
  for (final currentByte in inputBytes) {
    int carry = _reverseMap[currentByte];
    int i = 0;
    if (carry == -1) {
      throw FormatException('Invalid base58 character found: $currentByte');
    }
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
