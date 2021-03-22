import 'package:convert/convert.dart';
import 'package:solana/src/solana_serializable/serializable.dart';

class SerializableInt extends Serializable {
  SerializableInt.from(this._value);

  final int _value;

  @override
  List<int> serialize() {
    final String string = _value.toRadixString(16);
    return hex.decode(string.padLeft(2, '0'));
  }
}
