part of 'encoder.dart';

class _CompactU16 extends ByteArray {
  _CompactU16(int value) {
    final List<int> data = List<int>.empty(growable: true);
    int rawValue = value;
    while (rawValue != 0) {
      final int currentByte = rawValue & 0x7f;
      rawValue >>= 7;
      if (rawValue == 0) {
        data.add(currentByte);
      } else {
        data.add(currentByte | 0x80);
      }
    }
    _data = data;
  }

  late final ByteArray _data;

  @override
  Iterator<int> get iterator => _data.iterator;
}
