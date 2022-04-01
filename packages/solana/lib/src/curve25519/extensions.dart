extension IntegerListExt on List<BigInt> {
  BigInt bit(int offset) => (this[offset >> 3] >> (offset & 7)) & BigInt.one;

  bool compareAll(List<BigInt> other) {
    if (length != other.length) {
      return false;
    }
    for (int i = 0; i < length; ++i) {
      if (this[i] != other[i]) {
        return false;
      }
    }

    return true;
  }
}
