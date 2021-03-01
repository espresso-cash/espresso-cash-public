import 'package:convert/convert.dart';
import 'package:solana_dart/src/types/serializable.dart';

class SerializableInt extends Serializable {
  SerializableInt.from(this._value);

  final int _value;

  @override
  List<int> serialize() {
    String string = _value.toRadixString(16);
    return hex.decode(string.padLeft(2, '0'));
  }
}
