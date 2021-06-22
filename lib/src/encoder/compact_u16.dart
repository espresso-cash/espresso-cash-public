part of 'encoder.dart';

class CompactU16 extends Iterable<int> {
  CompactU16(int value) {
    final List<int> data = List<int>.empty(growable: true);
    int rawValue = value;
    // ignore: literal_only_boolean_expressions
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

  late final Iterable<int> _data;

  @override
  Iterator<int> get iterator => _data.iterator;
}
