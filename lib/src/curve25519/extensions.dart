part of 'curve25519.dart';

extension on List<int> {
  int _bit(int offset) => (this[offset >> 3] >> (offset & 7)) & 1;

  int _fastEqual(List<int> other) {
    int result = 0;
    if (length != other.length) {
      return 0;
    }
    for (int i = 0; i < length; ++i) {
      result |= this[i] ^ other[i];
    }
    return result._fastEqual(0);
  }
}

extension on int {
  int _fastEqual(int other) {
    int result = 0;
    final int xor = this ^ other;
    for (int i = 0; i < 8; ++i) {
      result |= xor >> i;
    }
    return (result ^ 0x01) & 0x01;
  }
}
