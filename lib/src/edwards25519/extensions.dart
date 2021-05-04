extension ListExtension on List<int> {
  int bit(int offset) => (this[offset >> 3] >> (offset & 7)) & 1;

  int fastEqual(List<int> other) {
    int result = 0;
    if (length != other.length) {
      return 0;
    }
    for (int i = 0; i < length; ++i) {
      result |= this[i] ^ other[i];
    }
    return result.fastEqual(0);
  }
}

extension IntExtension on int {
  int fastEqual(int other) {
    int result = 0;
    final int xor = this ^ other;
    for (int i = 0; i < 8; ++i) {
      result |= xor >> i;
    }
    return (result ^ 0x01) & 0x01;
  }
}
