import 'dart:collection';

class Byte extends ListBase<int> {
  Byte._(this._value);

  factory Byte.from(int value) => Byte._(value);

  late final int _value;

  @override
  int length = 1;

  @override
  int operator [](int index) => _value;

  @override
  void operator []=(int index, int value) {
    _value = value;
  }
}
