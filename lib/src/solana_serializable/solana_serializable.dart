library solana_serializable;

import 'package:convert/convert.dart';

export 'address.dart';
export 'compact_array.dart';
export 'compact_u16.dart';
export 'instruction.dart';
export 'message.dart';
export 'message_header.dart';
export 'signature.dart';
export 'signed_transaction.dart';

// ignore: one_member_abstracts
abstract class Serializable {
  List<int> serialize();
}

class SerializableInt extends Serializable {
  SerializableInt.from(this._value);

  final int _value;

  @override
  List<int> serialize() {
    final String string = _value.toRadixString(16);
    return hex.decode(string.padLeft(2, '0'));
  }
}
