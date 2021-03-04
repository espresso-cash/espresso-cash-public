import 'package:solana_dart/src/solana_serializable/serializable.dart';

class Compact_u16 extends Serializable {
  Compact_u16(this._value);

  final int _value;

  @override
  List<int> serialize() {
    List<int> bytes = List<int>.filled(0, 0, growable: true);
    int unencodedValue = _value;
    while (true) {
      int currentByte = unencodedValue & 0x7f;
      unencodedValue >>= 7;
      if (unencodedValue == 0) {
        bytes.add(currentByte);
        return bytes;
      }
      bytes.add(currentByte | 0x80);
    }
  }
}
