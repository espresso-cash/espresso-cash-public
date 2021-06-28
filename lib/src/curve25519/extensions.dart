part of 'curve25519.dart';

extension on List<int> {
  int _bit(int offset) => (this[offset >> 3] >> (offset & 7)) & 1;

  bool _compareAll(List<int> other) {
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
