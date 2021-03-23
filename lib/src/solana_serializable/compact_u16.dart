import 'package:solana/src/solana_serializable/serializable.dart';

class CompactU16 extends Serializable {
  CompactU16(this._value);

  final int _value;

  @override
  List<int> serialize() {
    final List<int> bytes = List<int>.filled(0, 0, growable: true);
    int unencodedValue = _value;
    // ignore: literal_only_boolean_expressions
    while (true) {
      final int currentByte = unencodedValue & 0x7f;
      unencodedValue >>= 7;
      if (unencodedValue == 0) {
        bytes.add(currentByte);
        return bytes;
      }
      bytes.add(currentByte | 0x80);
    }
  }
}
